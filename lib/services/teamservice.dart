import 'package:medgo/services/helper.dart';

getTeamData(Map<String, dynamic> data) {
  return makeHttpRequest('/user/team_list', 'get', data);
}
