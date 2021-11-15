import 'dart:io';

import 'package:_14/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function({
    required String email,
    required String username,
    required String password,
    required bool isLogin,
    required BuildContext ctx,
    File? image,
  }) onSubmit;
  final bool isLoading;

  const AuthForm({
    Key? key,
    required this.onSubmit,
    required this.isLoading,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File? _userImage;

  void _submit(BuildContext ctx) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImage == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick a image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(
        email: _userEmail,
        username: _userName,
        password: _userPassword,
        isLogin: _isLogin,
        ctx: ctx,
        image: _userImage,
      );
    }
  }

  void _onSelectImage(File? image) {
    _userImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(onSelect: _onSelectImage),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid e-mail address';
                    }
                    return null;
                  },
                  onSaved: (value) => _userEmail = value ?? '',
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                    onSaved: (value) => _userName = value ?? '',
                    decoration: const InputDecoration(
                      labelText: 'User name',
                    ),
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 7) {
                      return 'Please enter a valid password with at least 7 characters';
                    }
                    return null;
                  },
                  onSaved: (value) => _userPassword = value ?? '',
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                if (widget.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (widget.isLoading)
                  const CircularProgressIndicator()
                else
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have a account'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
