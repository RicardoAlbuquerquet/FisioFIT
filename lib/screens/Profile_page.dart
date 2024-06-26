import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'home_screen.dart';
import 'profile_edit_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String _username = '';
  String _email = '';
  String _phoneNumber = '';
  String _birthdate = '';
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    try {
      List<AuthUserAttribute> attributes =
          await Amplify.Auth.fetchUserAttributes();
      setState(() {
        _username = _getAttributeValue(attributes, AuthUserAttributeKey.name) ??
            'Nome não disponível';
        _email = _getAttributeValue(attributes, AuthUserAttributeKey.email) ??
            'Email não disponível';
        _phoneNumber =
            _getAttributeValue(attributes, AuthUserAttributeKey.phoneNumber) ??
                'Telefone não disponível';
        _birthdate =
            _getAttributeValue(attributes, AuthUserAttributeKey.birthdate) ??
                'Data de nascimento não disponível';
        _isEmailVerified =
            _getAttributeValue(attributes, AuthUserAttributeKey.emailVerified)
                    ?.toLowerCase() ==
                'true';
        _isPhoneVerified = _getAttributeValue(
                    attributes, AuthUserAttributeKey.phoneNumberVerified)
                ?.toLowerCase() ==
            'true';
      });
    } catch (e) {
      print('Erro ao recuperar informações do usuário: $e');
    }
  }

  String? _getAttributeValue(
      List<AuthUserAttribute> attributes, AuthUserAttributeKey key) {
    var attribute = attributes.firstWhere(
        (attribute) => attribute.userAttributeKey == key,
        orElse: () => AuthUserAttribute(userAttributeKey: key, value: ''));
    return attribute.value.isNotEmpty ? attribute.value : null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _widgetOptions = [
      HomeScreen(),
      _buildProfileView(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_accounts_sharp),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileEditScreen(
                          username: _username,
                          email: _email,
                          phoneNumber: _phoneNumber,
                          birthdate: _birthdate,
                        )),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildProfileView() {
    final profileItems = [
      _ProfileItem(label: 'Email', value: _email, isVerified: _isEmailVerified),
      _ProfileItem(
          label: 'Phone number',
          value: _phoneNumber,
          isVerified: _isPhoneVerified),
      _ProfileItem(label: 'Birthdate', value: _birthdate),
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: <Widget>[
        const SizedBox(height: 40),
        CircleAvatar(
          radius: 50,
          child: const Icon(Icons.person, size: 50),
        ),
        const SizedBox(height: 20),
        Text(
          _username,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ...profileItems.map((item) => _userInfoSection(item)).toList(),
        _logoutButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _userInfoSection(_ProfileItem item) {
    return Column(
      children: [
        _buildUserInfoTile(item.label, item.value, item.isVerified),
        const Divider(),
      ],
    );
  }

  Future<void> _handleLogout() async {
    await Amplify.Auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  Widget _buildUserInfoTile(String title, String value, [bool? isVerified]) {
    Widget trailingWidget = const Icon(Icons.date_range_outlined);
    if (isVerified != null) {
      trailingWidget =
          isVerified ? const Icon(Icons.verified_user) : _verificationButton();
    }

    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: trailingWidget,
    );
  }

  Widget _verificationButton() {
    return TextButton(
      onPressed: _verifyPhoneNumber,
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
      child: const Text('Verify', textAlign: TextAlign.center),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    print('Iniciando processo de verificação do número de telefone...');
  }

  Widget _logoutButton() {
    return ElevatedButton(
      onPressed: _handleLogout,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
      child: const Text('Logout'),
    );
  }
}

class _ProfileItem {
  final String label;
  final String value;
  final bool? isVerified;

  _ProfileItem({required this.label, required this.value, this.isVerified});
}
