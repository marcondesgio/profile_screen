import 'dart:io';
import 'package:flutter/material.dart';
import 'package:profile/src/controller/controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _profileController = ProfileController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

   @override
  void initState() {
    super.initState();
    _profileController.addListener(_onUserChanged);
  }

  void _onUserChanged() {
    setState(() {}); 
  }

  Color get primaryColor =>
      !_profileController.dark ? Colors.grey[900]! : Colors.grey[100]!;
  Color get secondaryColor =>
      !_profileController.dark ? Colors.grey[800]! : Colors.grey[100]!;
  Color get backgroundColor =>
      !_profileController.dark ? Colors.grey[100]! : Colors.grey[900]!;
  Color get cardColor =>
      !_profileController.dark ? Colors.white : Colors.grey[800]!;

  void _showEditDialog(String field) {
    TextEditingController dialogController = TextEditingController();
    String currentValue = '';
    String title = '';

    switch (field) {
      case 'name':
        currentValue = _profileController.name;
        title = 'Editar Nome';
        break;
      case 'email':
        currentValue = _profileController.email;
        title = 'Editar Email';
        break;
      case 'phone':
        currentValue = _profileController.phone;
        title = 'Editar Telefone';
        break;
      case 'bio':
        currentValue = _profileController.bio;
        title = 'Editar Bio';
        break;
    }

    dialogController.text = currentValue;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: TextFormField(
          style: TextStyle(color: primaryColor, decorationThickness: 0),
          cursorColor: primaryColor,
          controller: dialogController,
          decoration: InputDecoration(
            hintText: 'Digite o novo valor...',
            hintStyle: TextStyle(color: primaryColor),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar', style: TextStyle(color: primaryColor)),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: secondaryColor),
            onPressed: () {
              switch (field) {
                case 'name':
                  _profileController.updateName(dialogController.text);
                  break;
                case 'email':
                  _profileController.updateEmail(dialogController.text);
                  break;
                case 'phone':
                  _profileController.updatePhone(dialogController.text);
                  break;
                case 'bio':
                  _profileController.updateBio(dialogController.text);
                  break;
              }
              Navigator.pop(context);
            },
            child: Text('Salvar', style: TextStyle(color: backgroundColor)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _profileController.removeListener(_onUserChanged);
    _profileController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Perfil do Usuário', style: TextStyle(color: primaryColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _profileController.clear,
            tooltip: 'Resetar Perfil',
            color: primaryColor,
          ),
          IconButton(
            icon: _profileController.dark
                ? Icon(Icons.sunny)
                : Icon(Icons.dark_mode),
            color: primaryColor,
            onPressed: () {
              _profileController.updateColor(!_profileController.dark);
            },
            tooltip: 'Alternar Tema',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 24,
          children: [
            if (_profileController.name.isNotEmpty)
              Card(
                color: cardColor,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _profileController.selectProfileImage(
                          context,
                          themeColors.backgroundColor,
                          themeColors.primaryColor,
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.deepPurple[600],
                          backgroundImage: _profileController.image != null
                              ? FileImage(_profileController.image!)
                              : null,
                          child: _profileController.image == null
                              ? Text(
                                  _profileController.name[0].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        _profileController.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _profileController.email,
                        style: TextStyle(fontSize: 16, color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            Card(
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informações do Perfil',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow('Nome', _profileController.name, 'name'),
                    _buildInfoRow('Email', _profileController.email, 'email'),
                    _buildInfoRow('Telefone', _profileController.phone, 'phone'),
                    _buildInfoRow('Bio', _profileController.bio, 'bio'),
                    _buildAgeSection(),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.red[100],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dados do Controller (Debug):',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _profileController.userData.toString(),
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, String field) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: TextStyle(color: primaryColor)),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.edit, size: 18),
              onPressed: () => _showEditDialog(field),
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Idade:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${_profileController.age} anos',
              style: TextStyle(color: primaryColor),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _profileController.decrementAge,
                  color: primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _profileController.incrementAge,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
