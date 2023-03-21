import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String label;
  final Function(String?) onSave;
  final FormFieldValidator isValid;
  final String? value;
  const CustomTextField({Key? key, required this.label, required this.onSave, required this.isValid, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabled: true,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey[200]!,
                  width: 1
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black87),
        ),
        cursorColor: Colors.black87,
        cursorWidth: 1,
        onSaved: onSave,
        validator: isValid,
        initialValue: value,
      ),
    );
  }
}
