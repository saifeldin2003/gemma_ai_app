import 'package:flutter_gemma/core/message.dart';
import 'package:flutter_gemma/core/model.dart';
import 'package:flutter_gemma/flutter_gemma_interface.dart';
import 'package:flutter_gemma/pigeon.g.dart';

enum ModelState {
  initial,
  loading,
  prepareInstaling,
  newInstale,
  alreadyInstaled,
}
class States{
   ModelState states;
   States(this.states);
  copyWith(ModelState ?newStates){
   return States(newStates??states);
  }
}

class GemmaService {
 static final gemma = FlutterGemmaPlugin.instance;
static Stream<States> initalGemma() async* {
  final state = States(ModelState.initial);  
  yield state.copyWith(ModelState.loading);
    final isInstalled = await gemma.modelManager.isModelInstalled;
    if (!isInstalled) {
      yield state.copyWith(ModelState.prepareInstaling);
       gemma.modelManager
          .installModelFromAsset('gemma-1.1-2b-it-gpu-int4.bin').asStream();
          yield state.copyWith(ModelState.newInstale);
    } else {
      yield state.copyWith(ModelState.alreadyInstaled);
    }
  }

 static Future<String> massegeGemma(String message) async {
    final gemma1 = await gemma.createModel(
      modelType: ModelType.gemmaIt,
      preferredBackend: PreferredBackend.gpu,
      maxTokens: 512,
    );

    final session = await gemma1.createSession(
      temperature: 0.9,
      randomSeed: 1,
      topK: 1,
      topP: 0.2
    );
    await session.addQueryChunk(Message.text(text: message, isUser: true));
    String response = await session.getResponse();
    await session.close();
    return response;
  }
}
