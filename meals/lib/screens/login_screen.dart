import 'package:flutter/material.dart';
import '../models/login_model.dart';
//import '../services/auth_service.dart';
import '../services/authentication_service.dart';
import 'signUp_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter a Valid Username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Please Enter a Valid Password';
    }
    return null;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(181, 255, 255, 255),
              Color.fromARGB(234, 88, 169, 236),
              Color.fromARGB(255, 25, 143, 240),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/EventHub1.png',
                                  height: 170,
                                  width: 400,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 400,
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    width: 325,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _buildLoginForm(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/EventHub1.png',
                              height: 100,
                              width: 400,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 480,
                              width: 325,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _buildLoginForm(),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        const Text(
          "Hello",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Please Login to your Account",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: _validateUsername,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 250,
          child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.key),
            ),
            validator: _validatePassword,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              TextButton(
                onPressed: () {
                  _formKey.currentState?.reset();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final credentials = UserCredentials(
                username: _usernameController.text,
                password: _passwordController.text,
              );
              AuthService().login(context, credentials);
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.center,
                colors: [
                  Color.fromARGB(255, 5, 131, 235),
                  Color.fromARGB(255, 5, 131, 235),
                  Color.fromARGB(255, 5, 131, 235),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
