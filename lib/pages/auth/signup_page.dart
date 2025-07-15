import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signup() {
    if (formKey.currentState?.validate() ?? false) {
      if (kDebugMode) {
        print(nameController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                  validator: (value) {
                    if (value != null && value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.01),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: emailController,
                  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email regex pattern
                  final emailRegex = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                  },
                ),
                SizedBox(height: size.height * 0.01),
                TextFormField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                    _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                    ),
                    onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                    },
                  ),
                  ),
                  controller: passwordController,
                  validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password must contain at least one digit';
                  }
                  if (!RegExp(r'[!@#\$&*~_.,;:<>?%^]').hasMatch(value)) {
                    return 'Password must contain at least one special character';
                  }
                  return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: signup,
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
