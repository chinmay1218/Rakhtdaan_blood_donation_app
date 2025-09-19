import 'package:bb_ui/homescreen.dart';
import 'package:bb_ui/registration.dart';
import 'package:bb_ui/filter_blood.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginformkey= GlobalKey<FormState>();
  bool _passwordVisible = true;

  void initState() {
    _passwordVisible = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: heading(),
    );
  }

  heading() {
    return SingleChildScrollView(
    child:Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20,),
                  bottomRight: Radius.circular(20)
              )),
          height: 350,
          width: double.infinity,
          child: Image.asset("assets/bro.png"),
        ),
         signIn(),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Text(
                  "If you are a new user, Please get",
                  style: TextStyle(fontSize: 16)
              ),
              const SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  );
                  print('Text pressed!');
                },
                  child: const Text(
                    "Registered",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                    ),
                  )
              )
              //Text(
              //     "Sign In",
              //     style: TextStyle(fontSize: 17, color: Colors.blue)
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        loginButton("Immediate Search Donors"),
      ],
    ),
    );
  }

  Widget loginButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20)
        ),
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            if (text == "Immediate Search Donors") {
              // Navigate to the 'BookScreen' when the button is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Survey()),
              );
            }
            else if( text == "Sign In")  {
              // Navigate to the 'HomeScreen' when the button is clicked still need to be coded
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen(name: '', email: '', phone: '', gender: '', bgroup: '', dob: null, place: '',)),
              );
            }
          },


          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget signIn() {
    return Form(
      key: _loginformkey,
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            TextFormField(
              // controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.mail_rounded)),
              validator: (value){
                if(value == null || value.isEmpty || !value.contains('@')){
                  return 'Please enter a valid email';
                }
              },
            ),
            SizedBox( height: 10,),
            TextFormField(
              // controller: passController,
              keyboardType: TextInputType.text,
              // controller: _userPasswordController,
              obscureText:
              !_passwordVisible, //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    // color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter password';
                }
              },
            ),
            SizedBox( height: 20,),
            loginButton('Sign In')
          ],
        ),
      ),

    );

  }
}

