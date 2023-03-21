import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uptime_code/screens/get_all_items.dart';

import '../database/database_helper.dart';
import '../widgets/custom_text_field.dart';

class UpdateItem extends StatelessWidget {
  final List<Map> groups;
  final Map item;
  const UpdateItem({Key? key, required this.groups, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String itemName = '';
    String imageUrl = '';
    int price = 0;
    int code = 0;
    int stock = 0;
    int groupId = 0;
    GlobalKey<FormState> editItemFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new item '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: editItemFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: 'item name',
                    isValid: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid item name !';
                      }
                      return null;
                    },
                    onSave: (value) {
                      itemName = value!;
                      log(itemName);
                    },
                    value: item['name'],
                  ),
                  CustomTextField(
                    label: 'image url',
                    isValid: (value) {
                      if (value.isEmpty) {
                        return 'Enter a valid image url !';
                      }
                      return null;
                    },
                    onSave: (value) {
                      imageUrl = value!;
                      log(imageUrl);
                    },
                    value: item['image'],
                  ),
                  CustomTextField(
                    label: 'price',
                    isValid: (value) {
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid price number!';
                      }
                      return null;
                    },
                    onSave: (value) {
                      price = int.parse(value!);
                      log(price.toString());
                    },
                    value: item['price'].toString(),
                  ),
                  CustomTextField(
                    label: 'code',
                    isValid: (value) {
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid code number!';
                      }
                      return null;
                    },
                    onSave: (value) {
                      code = int.parse(value!);
                      log(code.toString());
                    },
                    value: item['code'].toString(),
                  ),
                  CustomTextField(
                    label: 'stock',
                    isValid: (value) {
                      if (value.isEmpty || !RegExp(r"^[0-9]").hasMatch(value)) {
                        return 'Enter a valid stock number!';
                      }
                      return null;
                    },
                    onSave: (value) {
                      stock = int.parse(value!);
                      log(stock.toString());
                    },
                    value: item['stock'].toString(),
                  ),
                  DropdownButtonFormField(
                    value: item['group_id'],
                    items: List.generate(
                        groups.length,
                        (index) => DropdownMenuItem(
                              value: groups[index]['id'],
                              child: Text(groups[index]['name']),
                            )),
                    onChanged: (value) {
                      groupId = int.parse('$value');
                      log(groupId.toString());
                    },
                    onSaved: (value) {
                      if (value == item['group_id']) {
                        groupId = item['group_id'];
                        log(groupId.toString());
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Select a group please !';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      final isValid = editItemFormKey.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      editItemFormKey.currentState?.save();
                      try {
                        DatabaseHelper().updateItem(groupId, code, price, stock,
                            item['id'], itemName, imageUrl);
                      } catch (e) {
                        log(e.toString());
                      }
                      editItemFormKey.currentState?.reset();
                      List<Map> groups = await DatabaseHelper().getGroups();
                      DatabaseHelper().getItems().then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GetAllItems(groups: groups, items: value)));
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$itemName $code '),
                          backgroundColor: Colors.green[800],
                        ));
                      });
                    },
                    child: const Text('Edit this item'),
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
