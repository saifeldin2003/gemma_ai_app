import 'package:flutter/material.dart';
import 'package:gemma_app_ai/service/gemma_service.dart';
import 'package:gemma_app_ai/widgets/app_bar.dart';
import 'package:gemma_app_ai/model/chat_model.dart';
import 'package:gemma_app_ai/widgets/chat_list.dart';
import 'package:gemma_app_ai/widgets/gradinet_shimmer_text.dart';
import 'package:gemma_app_ai/widgets/model_preparing.dart';
import 'package:gemma_app_ai/widgets/text_field_send.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  bool _isModelThinking = false;
  bool _isModelReady = true;
  final List<ChatModel> _chatItems = [];
  TextEditingController controller = TextEditingController();
  static ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initial();
    });

    super.initState();
  }

  initial() async {
    GemmaService.initalGemma().listen((event) async {
      switch (event.states) {
        case ModelState.prepareInstaling:
          _isModelReady = false;
          _emit();
        case ModelState.newInstale:
          initial();
          return;
        case ModelState.alreadyInstaled:
          if (_isModelReady == false) {
            _isModelReady = true;
            _emit();
          }
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _chatItems.isEmpty && _isModelReady ? appBar() : null,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                ChatList(controller: scrollController, chatList: _chatItems),
                _isModelThinking ? GradientShimmerText() : SizedBox.shrink(),
                TextFieldSend(controller: controller, fun: () => _onSubmit()),
              ],
            ),
            !_isModelReady ? ModelPreparing() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  _onSubmit() async {
    if (!_isModelReady) return;
    _chatItems.add(ChatModel(isUser: true, message: controller.text));
    refreshScroll();
    _emit();
    await _modelTalk();
  }

  Future<String> _modelTalk() async {
    _isModelThinking = true;
    String message = controller.text;
    controller.clear();
    String response = await GemmaService.massegeGemma(message);
    _chatItems.add(ChatModel(isUser: false, message: response));
    _isModelThinking = false;
    _emit();
    return response;
  }

  static refreshScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  _emit() => setState(() {});
}
