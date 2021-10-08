import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_amplify_todo/amplifyconfiguration.dart';
import 'package:aws_amplify_todo/auth/signin.dart';
import 'package:aws_amplify_todo/home.dart';
import 'package:aws_amplify_todo/loading.dart';
import 'package:aws_amplify_todo/models/ModelProvider.dart';
import 'package:aws_amplify_todo/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserLoginStatus(userLoggedIn: false)),
        ChangeNotifierProvider(
          create: (_) => CurrUser(awsUser: [])),
      ],
    child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    bool _amplifyConfigured = false;
    bool _amplifyAuthComplete = false;

  @override
  void initState() {
    loadAppConfig();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Future<void> loadAppConfig() async {
    await _configureAmplify();
  }

  Future<void> _configureAmplify() async {

    await Amplify.addPlugin(AmplifyDataStore(modelProvider: ModelProvider.instance));
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.addPlugin(AmplifyAPI());

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    await getAuthStatus();
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAuthStatus() async {
    var _auth = Amplify.Auth;
    _auth.fetchAuthSession().then((val) {
      Provider.of<UserLoginStatus>(context, listen: false).changeUserStatus(val.isSignedIn);
      if(val.isSignedIn){
        setState((){ _amplifyAuthComplete = true; });
        var currUser = Amplify.Auth.getCurrentUser();
        Provider.of<CurrUser>(context, listen: false).changeUser(currUser);
        print('Logged In? : ${val.isSignedIn}');
        print(currUser);
      } else {
        setState((){ _amplifyAuthComplete = true; });
        return SignIn();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var loginState = Provider.of<UserLoginStatus>(context).userLoggedIn;

    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.mulish().fontFamily,
        ),
      title: 'Flutter AWS Amplify',
      home: _amplifyConfigured ? _amplifyAuthComplete ? loginState ? HomePage() : SignIn() : Loading() : Loading(),
      
    );
  }
}

