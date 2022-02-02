import 'package:medgo/services/helper.dart';

signIn(Map<String, dynamic> data) {
  return makeHttpRequest('auth/login', 'post', data);
}

checkLogin(Map<String, dynamic> data) {
  return makeHttpRequest('auth/check-login', 'post', data);
}

signup(Map<String, dynamic> data) {
  return makeHttpRequest('auth/signup', 'post', data);
}

resetPassword(Map<String, dynamic> data) {
  return makeHttpRequest('auth/reset-password', 'post', data);
}

checkresetPasswordCode(Map<String, dynamic> data) {
  return makeHttpRequest('auth/reset-password-code', 'post', data);
}

forgotPassword(Map<String, dynamic> data) {
  return makeHttpRequest('auth/forgot-password', 'post', data);
}

logout(Map<String, dynamic> data) {
  return makeHttpRequest('auth/logout', 'get', data);
}

checkUniqueValue(Map<String, dynamic> data) {
  return makeHttpRequest('auth/check-unique-value', 'post', data);
}

getUserProfile(Map<String, dynamic> data) {
  return makeHttpRequest('user/user-detail', 'post', data);
}

saveProfile(Map<String, dynamic> data) {
  return makeHttpRequest('auth/profile', 'post', data);
}
