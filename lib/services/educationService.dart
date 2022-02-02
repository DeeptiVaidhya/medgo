import 'package:medgo/services/helper.dart';

getEducationData(Map<String, dynamic> data) {
  return makeHttpRequest('/education/education-module', 'get', data);
}
