import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laam_assignment/models/user.dart';
import 'package:laam_assignment/movies/bloc.dart';
import 'package:laam_assignment/movies/page.dart';
import 'package:laam_assignment/utilities/network_repository.dart';
import 'package:laam_assignment/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpState createState() =>  _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  SignUpBloc? signupBloc;
  SharedPreferences? sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    sharedPreferences =  await SharedPreferences.getInstance();
    signupBloc = BlocProvider.of<SignUpBloc>(context);
    setState(() {
      emailEditingController.text = 'testcase@ymail.com';
      passwordEditingController.text = '123456';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpStates>(
        listener: (context, state) {
          if(state is SignUpButtonClickedSuccessState){
            print('user added'+state.signupResponseData.uid);
            sharedPreferences?.setBool('login', true);
            Navigator.pop(context);
          }
          if(state is NetworkErrorState){
            Utils.alertMessage(context, state.error.toUpperCase());
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpStates>(builder: (context, state) {
          final emailField = TextFormField(
              autofocus: false,
              controller: emailEditingController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("Please Enter Your Email");
                }
                // reg expression for email validation
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return ("Please Enter a valid email");
                }
                return null;
              },
              onSaved: (value) {
                emailEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ));
          final passwordField = TextFormField(
              autofocus: false,
              controller: passwordEditingController,
              obscureText: true,
              validator: (value) {
                RegExp regex = new RegExp(r'^.{6,}$');
                if (value!.isEmpty) {
                  return ("Password is required for login");
                }
                if (!regex.hasMatch(value)) {
                  return ("Enter Valid Password(Min. 6 Character)");
                }
              },
              onSaved: (value) {
                passwordEditingController.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ));
          final signUpButton = Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  signUp(emailEditingController.text, passwordEditingController.text);
                },
                child: Text(
                  "SignUp",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                )),
          );
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20),
                          emailField,
                          SizedBox(height: 20),
                          passwordField,
                          SizedBox(height: 20),
                          signUpButton,
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      signupBloc?.add(SignUpButtonClicked(email: email, password: password));
    }
  }

}
