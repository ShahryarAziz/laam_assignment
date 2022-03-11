import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laam_assignment/movies/bloc.dart';
import 'package:laam_assignment/movies/page.dart';
import 'package:laam_assignment/signup/bloc.dart';
import 'package:laam_assignment/signup/page.dart';
import 'package:laam_assignment/utilities/network_repository.dart';
import 'package:laam_assignment/utilities/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() =>  _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginBloc? loginBloc;
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init()async{
    sharedPreferences =  await SharedPreferences.getInstance();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    setState(() {
      emailController.text = 'testcase@ymail.com';
      passwordController.text = '123456';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginStates>(
        listener: (context, state) {
          if(state is LoginButtonClickedSuccessState){
            print('go to home'+state.loginResponseData.uid);
            sharedPreferences?.setBool('login', true);
            navigateToMoviesScreen();
          }
          if(state is NetworkErrorState){
            Utils.alertMessage(context, state.error.toUpperCase());
          }
        },
        child: BlocBuilder<LoginBloc, LoginStates>(builder: (context, state) {
          final emailField = TextFormField(
              autofocus: false,
              controller: emailController,
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
                emailController.text = value!;
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

          //password field
          final passwordField = TextFormField(
              autofocus: false,
              controller: passwordController,
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
                passwordController.text = value!;
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key),
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ));

          final loginButton = Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.redAccent,
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  signIn(emailController.text, passwordController.text);
                },
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                )),
          );
          return Scaffold(
            backgroundColor: Colors.white,
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
                          SizedBox(height: 45),
                          emailField,
                          SizedBox(height: 25),
                          passwordField,
                          SizedBox(height: 35),
                          loginButton,
                          SizedBox(height: 15),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Don't have an account? "),
                                GestureDetector(
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  onTap: () {
                                    navigateToSignupScreen();
                                  }
                                )
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      loginBloc!.add(LoginButtonClicked(email: email, password: password));
    }
  }

  void navigateToSignupScreen() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          BlocProvider<SignUpBloc>(
            create: (context) {
              return SignUpBloc(networkRepository: NetworkRepository(),);
            },
            child: SignUpPage(),
          ),
    ));
  }

  void navigateToMoviesScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          BlocProvider<MoviesBloc>(
            create: (context) {
              return MoviesBloc(networkRepository: NetworkRepository(),);
            },
            child: MoviesPage(),
          ),
    ));
  }

}
