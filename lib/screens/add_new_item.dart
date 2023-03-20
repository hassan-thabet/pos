
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uptime_code/database/database_helper.dart';

import '../widgets/custom_text_field.dart';
class AddNewItem extends StatelessWidget {
  final List<Map> groups;
  const AddNewItem({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String itemName = '';
    String imageUrl = '';
    int price = 0 ;
    int code = 0 ;
    int stock = 0 ;
    int groupId = 0 ;
    GlobalKey<FormState> itemFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
            child: Form(
              key: itemFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'item name',
                    isValid: (value){
                      if (value.isEmpty) {
                        return 'Enter a valid item name !';
                      }
                      return null;
                    },
                    onSave: (value)
                    {
                      itemName = value!;
                    },
                  ),
                  CustomTextField(
                    label: 'image url',
                    isValid: (value){
                      if (value.isEmpty) {
                        return 'Enter a valid image url !';
                      }
                      return null;
                    },
                    onSave: (value)
                    {
                      imageUrl = value!;
                    },
                  ),
                  CustomTextField(
                    label: 'price',
                    isValid: (value){
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid price number!';
                      }
                      return null;
                    },
                    onSave: (value)
                    {
                      price = int.parse(value!);
                    },
                  ),
                  CustomTextField(
                    label: 'code',
                    isValid: (value){
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid code number!';
                      }
                      return null;
                    },
                    onSave: (value)
                    {
                      code = int.parse(value!);
                    },
                  ),
                  CustomTextField(
                    label: 'stock',
                    isValid: (value){
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid stock number!';
                      }
                      return null;
                    },
                    onSave: (value)
                    {
                      stock = int.parse(value!);
                    },
                  ),
                  DropdownButtonFormField(
                    hint: const Text('Choose Group'),
                      items: List.generate(groups.length, (index) => DropdownMenuItem(value: groups[index]['id'],child: Text(groups[index]['name']) ,)),
                      onChanged: (value){
                        groupId = int.parse('$value');
                      },
                    validator: (value){
                      if (value == null) {
                        return 'Select a group please !';
                      }
                      return null;
                    },
                  ),

                  TextButton(
                    onPressed: ()
                    async {
                      final isValid = itemFormKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      itemFormKey.currentState?.save();
                      DatabaseHelper().insertItem(itemName, imageUrl, price, stock, code, groupId);
                      itemFormKey.currentState?.reset();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$itemName Added successfully') , backgroundColor: Colors.green[800],)
                      );
                    },
                    child: const Text('Add New item'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
