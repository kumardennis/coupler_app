import 'dart:convert';

import 'package:coupler_app/color_scheme.dart';
import 'package:coupler_app/feature_Auth/widgets/custom_input.dart';
import 'package:coupler_app/shared_widgets/forward_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/supabase_auth_manger.dart';

class SignIn extends HookWidget {
  SignIn({Key? key}) : super(key: key);

  final _supabase = SupabaseAuthManger();

  @override
  Widget build(BuildContext context) {
    TextEditingController? textController1 = useTextEditingController();
    TextEditingController? textController2 = useTextEditingController();

    useEffect(() {
      getStoredCredentials() async {
        final prefs = await SharedPreferences.getInstance();

        final String? storedEmail = prefs.getString('email');

        final String? storedPassword = prefs.getString('password');

        if (storedEmail != null) textController1.text = storedEmail;

        if (storedPassword != null) textController2.text = storedPassword;

        if (storedEmail != null && storedPassword != null) {
          // await _supabase.signIn(storedEmail, storedPassword);
        }

        if (storedPassword != null) textController2.text = storedPassword;
      }

      getStoredCredentials();
      return null;
    }, []);

    void signIn() async {
      print('TEEST');
      await _supabase.signIn(textController1.text, textController2.text);
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.lightPink,
            Theme.of(context).colorScheme.lightBlue
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 111,
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomInput(
                          label: 'lbl_Username'.tr,
                          textController: textController1,
                        ),
                        CustomInput(
                          label: 'lbl_Password'.tr,
                          textController: textController2,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0x00FFFFFF),
                    ),
                    child: ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.dark,
                          elevation: 5,
                          fixedSize: const Size(100, 70)),
                      child: Text(
                        'btn_SignIn'.tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.light),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(30),
                      child: GestureDetector(
                          onTap: () {
                            Get.toNamed('/sign-up');
                          },
                          child: Text(
                            'lbl_SignUp'.tr,
                            style: Theme.of(context).textTheme.bodySmall,
                          )))
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: SocialLoginButton(
                  //     buttonType: SocialLoginButtonType.facebook,
                  //     onPressed: () {
                  //       signIn();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
