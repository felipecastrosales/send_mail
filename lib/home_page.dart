import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                    validator: validator,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: validator,
                  ),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(hintText: 'Subject'),
                    validator: validator,
                  ),
                  TextFormField(
                    controller: _messageController,
                    decoration: const InputDecoration(hintText: 'Message'),
                    validator: validator,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          sendEmail(
                            name: _nameController.text,
                            email: _emailController.text,
                            message: _messageController.text,
                            subject: _subjectController.text,
                          );

                          for (var controller in [
                            _nameController,
                            _emailController,
                            _messageController,
                            _subjectController
                          ]) {
                            controller.clear();
                          }
                        }
                      },
                      child: const Text('Send'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String message,
    required String subject,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = Keys.serviceId;
    const templateId = Keys.templateId;
    const userId = Keys.userId;
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': email,
            'user_message': message,
            'to_email': 'soufeliposales@gmail.com',
          }
        },
      ),
    );

    return response;
  }

  static String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Invalid.';
    }

    return null;
  }
}

/// add respective values to the keys
class Keys {
  static const serviceId = '';
  static const templateId = '';
  static const userId = '';
}
