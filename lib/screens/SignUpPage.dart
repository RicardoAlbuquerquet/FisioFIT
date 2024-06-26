import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController confirmationCodeController =
      TextEditingController();

  bool isSignUpComplete = false;

  // Utilize um Future para obter a data
  Future<void> _pickBirthdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select your birthdate',
    );
    if (picked != null) {
      setState(() {
        birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 48),
            _buildTextField(emailController, 'Email', Icons.email,
                TextInputType.emailAddress),
            _buildTextField(
                passwordController, 'Password', Icons.lock, TextInputType.text,
                isPassword: true),
            _buildTextField(
                nameController, 'Full Name', Icons.person, TextInputType.text),
            _buildDatePickerField(context, birthdateController,
                'Birthdate (YYYY-MM-DD)', Icons.cake),
            _buildPhoneNumberField(phoneNumberController,
                'Phone Number (with country code)', Icons.phone),
            SizedBox(height: 32),
            isSignUpComplete
                ? _buildConfirmationSection()
                : _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, TextInputType keyboardType,
      {bool isPassword = false}) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            labelText: label,
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              icon,
              color: Color(0xFF66FFCC),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: isPassword,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDatePickerField(BuildContext context,
      TextEditingController controller, String label, IconData icon) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            labelText: label,
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              icon,
              color: Color(0xFF66FFCC),
            ),
          ),
          readOnly: true,
          onTap: () => _pickBirthdate(context),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPhoneNumberField(
      TextEditingController controller, String label, IconData icon) {
    return Column(
      children: [
        InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          selectorConfig:
              const SelectorConfig(selectorType: PhoneInputSelectorType.DIALOG),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          initialValue: PhoneNumber(isoCode: 'BR'),
          textFieldController: controller,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(
              signed: false, decimal: false),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(),
            labelText: label,
            prefixIcon: Icon(icon, color: const Color(0xFF66FFCC)),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: signUp,
      child: const Text('Sign Up'),
    );
  }

  Widget _buildConfirmationSection() {
    return Column(
      children: [
        _buildTextField(confirmationCodeController, 'Confirmation Code',
            Icons.verified_user, TextInputType.number),
        ElevatedButton(
          onPressed: confirmSignUp,
          child: const Text('Confirm Sign Up'),
        ),
      ],
    );
  }

  Future<void> signUp() async {
    try {
      final SignUpOptions options = SignUpOptions(
        userAttributes: {
          CognitoUserAttributeKey.email: emailController.text.trim(),
          CognitoUserAttributeKey.name: nameController.text.trim(),
          CognitoUserAttributeKey.birthdate: birthdateController.text.trim(),
          CognitoUserAttributeKey.phoneNumber:
              phoneNumberController.text.trim(),
        },
        pluginOptions: const CognitoSignUpPluginOptions(
          clientMetadata: {
            'customKey': 'customValue',
          },
        ),
      );
      final SignUpResult result = await Amplify.Auth.signUp(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
        options: options,
      );
      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Sign up complete, please confirm it in your email.')),
        );
        setState(() {
          isSignUpComplete = true;
        });
      } else {
        setState(() {
          isSignUpComplete = true;
        });
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing up: ${e.message}')),
      );
    }
  }

  Future<void> confirmSignUp() async {
    try {
      final SignUpResult result = await Amplify.Auth.confirmSignUp(
        username: emailController.text.trim(),
        confirmationCode: confirmationCodeController.text.trim(),
      );
      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email confirmed, you can now sign in.')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // Handle next steps
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error confirming sign up: ${e.message}')),
      );
    }
  }
}
