import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String hintText;
  final Icon icon;
  final TextEditingController controller;

  PasswordField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  late String? _passwordError;

  @override
  void initState() {
    super.initState();
    _passwordError = null; // Initialisation de _passwordError à null
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscureText,
            decoration: InputDecoration(
              filled: true,
              hintText: widget.hintText,
              prefixIcon: widget.icon,
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorText: _passwordError,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un mot de passe';
              } else if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              _validatePassword(value);
            },
          ),
        ),
      ],
    );
  }

  void _validatePassword(String value) {
  setState(() {
    if (value.isEmpty) {
      _passwordError = 'Veuillez saisir un mot de passe';
    } else if (value.length < 8) {
      _passwordError = 'Le mot de passe doit contenir au moins 8 caractères';
    } else if (!containsLetter(value) || !containsNumber(value) || !containsCapitalLetter(value)) {
      _passwordError = 'Le mot de passe doit contenir au moins une lettre, un chiffre, et une lettre majuscule';
    } else {
      _passwordError = null;
    }
  });
}

bool containsLetter(String value) {
  // Vérifie si la chaîne contient au moins une lettre
  return RegExp(r'[a-zA-Z]').hasMatch(value);
}

bool containsNumber(String value) {
  // Vérifie si la chaîne contient au moins un chiffre
  return RegExp(r'\d').hasMatch(value);
}

bool containsCapitalLetter(String value) {
  // Vérifie si la chaîne contient au moins une lettre majuscule
  return RegExp(r'[A-Z]').hasMatch(value);
}

}