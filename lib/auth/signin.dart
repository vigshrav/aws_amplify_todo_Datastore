import 'package:aws_amplify_todo/auth/auth.dart';
import 'package:aws_amplify_todo/auth/signup.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late String email, pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Sign In', style: TextStyle(fontSize: 22.0),),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Flexible(child: Text("Enter your credentials to login")),
                ],
              ),
              SizedBox(height: 25.0,),
              Form(key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.alternate_email, color: Colors.blue),
                        labelText: 'email id',
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      //obscureText: true,
                      validator: (val) => val!.isEmpty ? 'email is required' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key, color: Colors.blue),
                        labelText: 'password',
                        hintText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0),),
                          borderSide: BorderSide(color: Colors.blue)
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (val) => val!.isEmpty ? 'password is required' : null,
                      onChanged: (val) {
                        setState(() => pwd = val);
                      }
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(child: Text('LOGIN'), onPressed: () async {
                      await AuthServices().userSignIn(email, pwd, context);
                    },),
                  ],
                ),
              ),
              TextButton(child: Text('Don\'t have an account?', style: TextStyle(color: Colors.blue),), onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              },),
              // TextButton(child: Text('Forgot Password', style: TextStyle(color: Colors.blue),), onPressed: () async {},)
            ],
          ),
        ),
      ),
    );
  }
}