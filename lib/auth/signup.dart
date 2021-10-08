import 'package:aws_amplify_todo/auth/auth.dart';
import 'package:aws_amplify_todo/auth/signin.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late String uname, email, pwd, phno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register'),
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
                  Text('Sign Up', style: TextStyle(fontSize: 22.0),),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                children: [
                  Flexible(child: Text("Let's create your account")),
                ],
              ),
              SizedBox(height: 25.0,),
              Form(key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        labelText: 'first and last name',
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
                      keyboardType: TextInputType.text,
                      //obscureText: true,
                      validator: (val) => val!.isEmpty ? 'name is required' : null,
                      onChanged: (val) {
                        setState(() => uname = val);
                      }
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                        labelText: 'phone number',
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
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() => phno = val);
                      }
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(child: Text('REGISTER'), onPressed: () async {
                      var _phno = '+91$phno';
                      await AuthServices().userSignUp(uname, pwd, _phno, email, context);
                    },),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(child: Text('Have an account?', style: TextStyle(color: Colors.blue),), onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              },)
            ],
          ),
        ),
      ),
    );
  }
}