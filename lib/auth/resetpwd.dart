import 'package:flutter/material.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({ Key? key }) : super(key: key);

  @override
  _ResetPwdState createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
    );
  }
}