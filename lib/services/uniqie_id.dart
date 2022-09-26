import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

String getUid() {
  var uuid = const Uuid();
  return uuid.v4();
}
