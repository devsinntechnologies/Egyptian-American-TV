import 'package:egy_us_tv_admin/controller/provider/login_provider.dart';
import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:egy_us_tv_admin/view/bottombar.dart';
import 'package:egy_us_tv_admin/view/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../config/color.dart';
import '../../config/images.dart';
import '../../widgets/custom_textfield.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Builder(
          builder: (context) {
            var myProvider = context.watch<LoginProvider>();
            return myProvider.isLoading ? Center(child: CircularProgressIndicator.adaptive(),) : Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                // color: colorPrimaryDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage(AppImages.splash),
                          height: 150,
                          width: 250,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Login to EGY US TV',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.primaryColor
                              // fontFamily: fNSfUiSemiBold,
                              ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 250,
                                child: CustomFormField(
                                  color: Colors.white70,
                                  hintText: "username/email",
                                  icon: Icons.email,
                                  border: 10,
                                  controller: email,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'username/email is required';
                                    }
                                    // Add additional password validation if needed
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 250,
                                child: CustomFormField(
                                  color: Colors.white70,
                                  hintText: "Password",
                                  icon: Icons.lock,
                                  border: 10,
                                  isPasswordField: true,
                                  controller: password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password is required';
                                    }
                                    // Add additional password validation if needed
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus!.unfocus();

                              var provider = context.read<LoginProvider>();
                              provider.login(context,email: email.text,password: password.text);
                           
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: ColorConstants.primaryColor)),
                            height: 45,
                            width: 250,
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: ColorConstants.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        // Text(
                        //   'By continuing, you agree to  Muslim Match\'s terms of use\nand confirm that you have read our privacy policy.',
                        //   style: TextStyle(
                        //     color: ColorConstants.colorTextLight,
                        //     fontSize: 12,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Text('Term of use'),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => WebViewScreen(2),
                                //   ),
                                // );
                              },
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              child: Text('Privacy Policy'),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => WebViewScreen(3),
                                //   ),
                                // );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
