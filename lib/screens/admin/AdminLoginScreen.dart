import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:FmI/AppLocalizations.dart';
import 'package:FmI/components/LanguageSelectionWidget.dart';
import 'package:FmI/screens/admin/AdminDashboardScreen.dart';
import 'package:FmI/services/AuthService.dart';
import 'package:FmI/utils/Colors.dart';
import 'package:FmI/utils/Common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class AdminLoginScreen extends StatefulWidget {
  static String tag = '/AdminLoginScreen';

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController =
      TextEditingController(text: '');
  TextEditingController passwordController =
      TextEditingController(text: '');

  FocusNode passFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      appStore.setLoading(true);

      await signInWithEmail(emailController.text, passwordController.text)
          .then((user) {
        appStore.isAdmin = true;
        log("compoonents/AdminLoginScreen.dart/signInWithEmail()");
        log(appStore.isAdmin);
        AdminDashboardScreen().launch(context, isNewTask: true);
        appStore.setLoading(false);

        if (user != null) {
          log("compoonents/AdminLoginScreen.dart/json");
          log(user.toJson());

          if (user.isAdmin.validate() || user.isTester.validate()) {
            AdminDashboardScreen().launch(context, isNewTask: true);
          } else {
            logout(context);
            toast('not_allowed'.translate);
          }
        }
      }).catchError((e) {
        appStore.setLoading(false, toastMsg: e.toString());
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: 500,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/app_logo.png', height: 100),
                    16.height,
                    Text('login_Title'.translate,
                        style: boldTextStyle(size: 22)),
                    20.height,
                    AppTextField(
                      controller: emailController,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(labelText: 'email'.translate),
                      nextFocus: passFocus,
                      autoFocus: true,
                    ),
                    8.height,
                    AppTextField(
                      controller: passwordController,
                      textFieldType: TextFieldType.PASSWORD,
                      focus: passFocus,
                      decoration:
                          inputDecoration(labelText: 'password'.translate),
                      onFieldSubmitted: (s) {
                        signIn();
                      },
                    ),
                    8.height,
                    AppButton(
                      text: 'login'.translate,
                      textStyle: boldTextStyle(color: white),
                      color: appStore.isDarkMode
                          ? scaffoldSecondaryDark
                          : colorPrimary,
                      onTap: () {
                        signIn();
                      },
                      width: context.width(),
                    ),
                    16.height,
                    LanguageSelectionWidget(),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) => Loader().visible(appStore.isLoading)),
          ],
        ),
      ).center(),
    );
  }
}
