import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/controller/auth/cubit.dart';
import 'package:socialapp/controller/cashHelper/cashHelper.dart';
import 'package:socialapp/model/auth/authStatus.dart';
import 'package:socialapp/view/screens/Home/HomeLayout.dart';
import 'package:socialapp/view/widgets/NavigateTo.dart';
import 'package:socialapp/view/widgets/TextFormField.dart';
import 'package:socialapp/view/widgets/button.dart';
import 'package:socialapp/view/widgets/toast.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthAppStatus>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }else if(state is LoginSuccessState){
           CashHelper.SaveData(key: 'uid', value: state.uid).then((value) {
                ToAndRemove(context, route: HomeScreen());
              });;
          }
        },
        builder: (context, state) => Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1512036849132-48508f294900?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTN8fG5hdHVyYWx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFieldWithLable(context, validate: (v) {
                            if (v.isEmpty || !v.contains('@gmail.com')) {
                              return 'enter email';
                            }
                          },
                              label: 'Email Address',
                              controller: emailController),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFieldWithLable(context,
                              isPassword: true,
                              obsecure: AuthCubit.get(context).obsecure,
                              validate: (v) {
                            if (v.isEmpty || v.length < 6) {
                              return 'enter password ';
                            }
                          }, label: 'Password', controller: passwordController),
                          const SizedBox(
                            height: 8,
                          ),
                          Align(alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: (){},
                            child: Text('forgoten password?',style: TextStyle(color: Colors.grey),),
                          ),
                          ),
                           const SizedBox(
                            height: 8,
                          ),
                          
                          const SizedBox(
                            height: 16,
                          ),
                          Button(
                              title: 'sign in',
                              press: () {
                                if (formkey.currentState!.validate()) {
                                  AuthCubit.get(context).LoginMethod(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              }),
                              SizedBox(height: 16,),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'keep Signed in ?',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Checkbox(
                                  checkColor: Colors.grey,
                                  value: AuthCubit.get(context).KeepSignedIn,
                                  activeColor: Colors.transparent,
                                  onChanged: (v) {
                                    AuthCubit.get(context)
                                        .KeepSignedInMethod(v!);
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
