import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_chat/components/user_image_picker.dart';
import 'package:project_chat/core/models/auth.form.data.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Image not selected');
    }

    widget.onSubmit(_formData);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).colorScheme.error,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                 UserImagePicker(onImagePick: _handleImagePick,),
                if (_formData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (name) {
                      final newName = name ?? '';

                      if (newName.trim().length < 5) {
                        return 'Name should have at least five characters';
                      }

                      return null;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (email) {
                    final newEmail = email ?? '';

                    if (!newEmail.contains('@')) {
                      return 'Invalid email pattern';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (password) {
                    final newPassword = password ?? '';

                    if (newPassword.length < 6) {
                      return 'Password should have at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: _submit,
                    child: Text(_formData.isLogin ? 'Login' : 'Signup')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    },
                    child: Text(_formData.isLogin
                        ? 'Create new account'
                        : 'Already have an account')),
              ],
            )),
      ),
    );
  }
}
