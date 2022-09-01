import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

String getUid() {
  var uuid = const Uuid();
  print(uuid.v4());
  return uuid.v4();
}
