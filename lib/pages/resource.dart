import 'package:innenu/utils/utils.dart';

Future<void> init() {
  return myNetWork.downLoadFile('resource/guide.zip').then((success) {});
}
