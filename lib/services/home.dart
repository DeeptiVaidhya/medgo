import 'package:medgo/services/helper.dart';

getCommunities(Map<String, dynamic> data) {
  return makeHttpRequest('studies/community_list', 'get', data);
}

getSurveyList(Map<String, dynamic> data) {
  return makeHttpRequest('survey/survey_list', 'get', data);
}

getFirstServeyQue(Map<String, dynamic> data) {
  return makeHttpRequest('survey/first_questionnaire', 'post', data);
}

getNextServeyQue(Map<String, dynamic> data) {
  return makeHttpRequest('survey/next_questionnaire', 'post', data);
}

getMedication(Map<String, dynamic> data) {
  return makeHttpRequest('user/get_medications', 'get', data);
}

getPharmacies(Map<String, dynamic> data) {
  return makeHttpRequest('user/get_pharmacies', 'get', data);
}

getLogMedicines(Map<String, dynamic> data) {
  return makeHttpRequest('user/get-log-medicines', 'get', data);
}

logMedicine(Map<String, dynamic> data) {
  return makeHttpRequest('user/log-medicine', 'post', data);
}
