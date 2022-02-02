import 'package:flutter/material.dart';
import 'package:medgo/pages/account/signup/signup.dart';
import 'package:medgo/pages/account/signup/signup_thankyou.dart';
import 'package:medgo/pages/account/user_account/user_account_detail.dart';
import 'package:medgo/pages/account/user_account/user_account_new.dart';
import 'package:medgo/pages/alert/medalert.dart';
import 'package:medgo/pages/alert/trophy1.dart';
import 'package:medgo/pages/education/education.dart';
//import 'package:medgo/pages/education/education_.dart';
import 'package:medgo/pages/forgotten_password/forgotten_password.dart';
import 'package:medgo/pages/forgotten_password/reset-password.dart';
import 'package:medgo/pages/home/illness_perceptions.dart';
import 'package:medgo/pages/home/assessment_complete.dart';
import 'package:medgo/pages/home/home.dart';
import 'package:medgo/pages/home/promispain.dart';
import 'package:medgo/pages/home/stigma.dart';
import 'package:medgo/pages/home/survey.dart';
import 'package:medgo/pages/home/symptom/choose_symptom_boy1.dart';
import 'package:medgo/pages/home/symptom/choose_symptom_confirm.dart';
import 'package:medgo/pages/home/symptom/choose_symptom_location.dart';
import 'package:medgo/pages/home/symptom/fatigue_intensity.dart';
import 'package:medgo/pages/home/symptom/lognext.dart';
import 'package:medgo/pages/home/symptom/mood_intensity.dart';
import 'package:medgo/pages/home/symptom/pain_intensity.dart';
import 'package:medgo/pages/home/symptom/stress_intensity.dart';
import 'package:medgo/pages/medication/detail_populated.dart';
import 'package:medgo/pages/medication/detail_populated1.dart';
import 'package:medgo/pages/medication/log_last_medication.dart';
import 'package:medgo/pages/medication/medication_list.dart';
import 'package:medgo/pages/more/community.dart';
import 'package:medgo/pages/more/more.dart';
import 'package:medgo/pages/more/pharmacies.dart';
import 'package:medgo/pages/notifications/notifications.dart';
import 'package:medgo/pages/page-not-found/page-not-found.dart';
import 'package:medgo/pages/sign-in/sign-in.dart';
import 'package:medgo/pages/welcome/welcome.dart';
import 'package:medgo/pages/your-team/your_team.dart';
// import 'package:medgo/services/navigationService.dart';
import 'package:page_transition/page_transition.dart';

class Routes extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _RoutesState createState() => _RoutesState();
}

final withoutLoginPage = [
  '/',
  '/signin',
  '/signup',
  '/forgottenpassword',
  '/signup-thankyou',
  '/reset-password'
];

class _RoutesState extends State<Routes> {
  @override
  // void initState() {
  //   Timer.periodic(new Duration(seconds: 10), (timer) {
  //     checkRouteLogin();
  //   });
  //   super.initState();
  // }

  // void checkRouteLogin() {
  //   String currentPath;
  //   locator<NavigationService>().navigatorKey.currentState?.popUntil((route) {
  //     currentPath = route.settings.name;
  //     return true;
  //   });
  //   var isWloginpage = withoutLoginPage.contains(currentPath);
  //   final LocalStorage storage = new LocalStorage('medgo');
  //   if (!isWloginpage) {
  //     checkLoginToken();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: locator<NavigationService>().navigatorKey,
      title: 'MEDGO',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (RouteSettings setting) {
        return new MaterialPageRoute(builder: (context) => PageNotFound());
      },
      onGenerateRoute: (settings) {
        var uri = Uri.parse(settings.name);
        //checkRouteLogin();
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'reset-password') {
          print(uri.pathSegments);
          var id = uri.pathSegments[1];
          return PageTransition(
              settings: settings,
              child: ResetPassword(code: id),
              type: PageTransitionType.fade);
        }
        var route = settings.name.toString();
        if (uri.pathSegments.length > 1) {
          route = '/' + uri.pathSegments[0];
        }

        if (uri.toString().contains('?')) {
          var r = uri.toString().split('?');
          route = r[0];
        }
        switch (settings.name) {
          case '/':
            return PageTransition(
                settings: settings,
                child: Welcome(),
                type: PageTransitionType.fade);
            break;

          case '/signin':
            return PageTransition(
                settings: settings,
                child: SignIn(),
                type: PageTransitionType.fade);
            break;
          case '/forgottenpassword':
            return PageTransition(
                settings: settings,
                child: ForgottenPassword(),
                type: PageTransitionType.fade);
            break;
          case '/signup':
            return PageTransition(
                settings: settings,
                child: Signup(),
                type: PageTransitionType.fade);
            break;
          case '/signup-thankyou':
            return PageTransition(
                settings: settings,
                child: SignUpThankYou(),
                type: PageTransitionType.fade);
            break;
          case '/alert_trophy':
            return PageTransition(
                settings: settings,
                child: AlertTrophy(),
                type: PageTransitionType.fade);
            break;
          case '/notifications':
            return PageTransition(
                settings: settings,
                child: Notifications(),
                type: PageTransitionType.fade);
            break;
          case '/home':
            return PageTransition(
                settings: settings,
                child: Home(),
                type: PageTransitionType.fade);
            break;
          case '/education':
            return PageTransition(
                settings: settings,
                child: Education(),
                type: PageTransitionType.fade);
            break;
          case '/yourteam':
            return PageTransition(
                settings: settings,
                child: YourTeam(),
                type: PageTransitionType.fade);
            break;
          case '/more':
            return PageTransition(
                settings: settings,
                child: More(),
                type: PageTransitionType.fade);
            break;
          case '/choose-symptom':
            return PageTransition(
                settings: settings,
                child: ChooseSymptomBoy1(),
                type: PageTransitionType.fade);
            break;
          case '/choose-symptom-confirm':
            return PageTransition(
                settings: settings,
                child: ChooseSymptomConfirm(),
                type: PageTransitionType.fade);
            break;
          case '/choose-symptom-location':
            return PageTransition(
                settings: settings,
                child: ChooseSymptomLocation(),
                type: PageTransitionType.fade);
            break;
          case '/pain-intensity':
            return PageTransition(
                settings: settings,
                child: PainIntensity(),
                type: PageTransitionType.fade);
            break;
          case '/fatigue-intensity':
            return PageTransition(
                settings: settings,
                child: FatigueIntensity(),
                type: PageTransitionType.fade);
            break;
          case '/mood-intensity':
            return PageTransition(
                settings: settings,
                child: MoodIntensity(),
                type: PageTransitionType.fade);
            break;
          case '/stress-intensity':
            return PageTransition(
                settings: settings,
                child: StressIntensity(),
                type: PageTransitionType.fade);
            break;
          case '/lognext':
            return PageTransition(
                settings: settings,
                child: LogNext(),
                type: PageTransitionType.fade);
            break;
          case '/loglast-medication':
            return PageTransition(
                settings: settings,
                child: LogLastMedication(),
                type: PageTransitionType.fade);
            break;
          case '/detail-populated':
            return PageTransition(
                settings: settings,
                child: DetailPopulated(),
                type: PageTransitionType.fade);
            break;
          case '/detail-populated1':
            return PageTransition(
                settings: settings,
                child: DetailPopulated1(),
                type: PageTransitionType.fade);
            break;
          case '/medicationlist':
            return PageTransition(
                settings: settings,
                child: MedicationList(),
                type: PageTransitionType.fade);
            break;
          case '/medalert':
            return PageTransition(
                settings: settings,
                child: MedAlert(),
                type: PageTransitionType.fade);
            break;
          case '/survey':
            return PageTransition(
                settings: settings,
                child: Survey(),
                type: PageTransitionType.fade);
            break;
          case '/promispain':
            return PageTransition(
                settings: settings,
                child: PromisPain(),
                type: PageTransitionType.fade);
            break;
          case '/assessment-complete':
            return PageTransition(
                settings: settings,
                child: AssessmentComplete(),
                type: PageTransitionType.fade);
            break;
          case '/illness-perceptions':
            return PageTransition(
                settings: settings,
                child: IllnessPerceptions(),
                type: PageTransitionType.fade);
            break;
          case '/stigma':
            return PageTransition(
                settings: settings,
                child: Stigma(),
                type: PageTransitionType.fade);
            break;
          case '/user-account-new':
            return PageTransition(
                settings: settings,
                child: UserAccountNew(),
                type: PageTransitionType.fade);
            break;
          case '/useraccount-detail':
            return PageTransition(
                settings: settings,
                child: UserAccountDetail(),
                type: PageTransitionType.fade);
            break;
          // case '/useraccount-detail':
          // return PageTransition(
          //     settings: settings,
          //     child: UserAccountDetail(),
          //     type: PageTransitionType.fade);
          // break;
          case '/community':
            return PageTransition(
                settings: settings,
                child: Community(),
                type: PageTransitionType.fade);
            break;
          case '/pharmacies':
            return PageTransition(
                settings: settings,
                child: Pharmacies(),
                type: PageTransitionType.fade);
            break;
          default:
            return null;
        }
      },
    );
  }
}
