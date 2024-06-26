import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileEditScreen extends StatefulWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String birthdate;

  const ProfileEditScreen({
    super.key,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthdate,
  });

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _phoneNumber;
  late String _birthdate;
  late TextEditingController _birthdateController;

  bool _isUsernameEditable = false;
  bool _isEmailEditable = false;
  bool _isPhoneNumberEditable = false;
  bool _isBirthdateEditable = false;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _email = widget.email;
    _phoneNumber = widget.phoneNumber;
    _birthdate = widget.birthdate;
    _birthdateController = TextEditingController(
      text: _formatDate(widget.birthdate),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdateController.text = DateFormat('dd/MM/yyyy').format(picked);
        _birthdate = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildEditableField(
                label: 'Username',
                currentValue: _username,
                isEditable: _isUsernameEditable,
                onToggle: () {
                  setState(() {
                    _isUsernameEditable = !_isUsernameEditable;
                  });
                },
                onSaved: (value) => _username = value ?? '',
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Email',
                currentValue: _email,
                isEditable: _isEmailEditable,
                onToggle: () {
                  setState(() {
                    _isEmailEditable = !_isEmailEditable;
                  });
                },
                onSaved: (value) => _email = value ?? '',
                validator: _emailValidator,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              _buildEditableField(
                label: 'Phone Number',
                currentValue: _phoneNumber,
                isEditable: _isPhoneNumberEditable,
                onToggle: () {
                  setState(() {
                    _isPhoneNumberEditable = !_isPhoneNumberEditable;
                  });
                },
                onSaved: (value) => _phoneNumber = value ?? '',
                validator: _requiredValidator,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Birthdate',
                controller: _birthdateController,
                isEditable: _isBirthdateEditable,
                onToggle: () {
                  setState(() {
                    _isBirthdateEditable = !_isBirthdateEditable;
                  });
                },
                onSaved: (value) => _birthdate = value ?? '',
                validator: _requiredValidator,
                context: context,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Save', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 32),
              _buildPremiumAccountSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String currentValue,
    required bool isEditable,
    required void Function() onToggle,
    required void Function(String?) onSaved,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: currentValue,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: validator,
                onSaved: onSaved,
                keyboardType: keyboardType,
                enabled: isEditable,
              ),
            ),
            IconButton(
              icon: Icon(
                isEditable ? Icons.lock_open : Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: onToggle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required bool isEditable,
    required void Function() onToggle,
    required void Function(String?) onSaved,
    required String? Function(String?) validator,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: isEditable ? () => _selectDate(context) : null,
                  ),
                ),
                validator: validator,
                onSaved: onSaved,
                readOnly: true,
                enabled: isEditable,
              ),
            ),
            IconButton(
              icon: Icon(
                isEditable ? Icons.lock_open : Icons.lock,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: onToggle,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FisioFitPRO!!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Start investing in yourself! Become a part of the team! Be a PRO!',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _buyPremiumAccount,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text('Become a PRO!!', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  void _buyPremiumAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Become a FisioFitPRO!!'),
          content: const Text(
              'Start investing in yourself! Become a part of the team! Be a PRO!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here, you can implement the purchase logic
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Premium account purchased successfully!')),
                );
              },
              child: const Text('Buy'),
            ),
          ],
        );
      },
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Save the profile data to Amplify or another service
      // For example:
      // Amplify.Auth.updateUserAttribute(
      //   userAttributeKey: AuthUserAttributeKey.name,
      //   value: _username,
      // );
      // Amplify.Auth.updateUserAttribute(
      //   userAttributeKey: AuthUserAttributeKey.email,
      //   value: _email,
      // );
      // Amplify.Auth.updateUserAttribute(
      //   userAttributeKey: AuthUserAttributeKey.phoneNumber,
      //   value: _phoneNumber,
      // );
      // Amplify.Auth.updateUserAttribute(
      //   userAttributeKey: AuthUserAttributeKey.birthdate,
      //   value: _birthdate,
      // );

      // Go back to the profile page
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }
}
