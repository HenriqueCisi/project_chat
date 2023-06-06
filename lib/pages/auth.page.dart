import 'package:flutter/material.dart';
import 'package:project_chat/components/auth.form.dart';
import 'package:project_chat/core/models/auth.form.data.dart';
import 'package:project_chat/core/services/auth/auth_mock_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthMockService().login(
          formData.email, 
          formData.password
          );
      } else {
        await AuthMockService().signup(
          formData.name, 
          formData.password, 
          formData.email, 
          formData.image);
      }
    } catch (error) {
      //Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
                child: AuthForm(
              onSubmit: _handleSubmit,
            )),
          ),
          if (_isLoading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(child: CircularProgressIndicator()),
            )
        ],
      ),
    );
  }
}
