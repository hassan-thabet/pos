
import 'package:flutter/material.dart';
import 'package:uptime_code/database/database_helper.dart';

import '../widgets/custom_text_field.dart';
class AddNewItem extends StatelessWidget {
  const AddNewItem({Key? key}) : super(key: key);

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
                    onSave: (value)
                    {
                      itemName = value!;
                    },
                  ),
                  CustomTextField(
                    label: 'image url',
                    onSave: (value)
                    {
                      imageUrl = value!;
                    },
                  ),
                  CustomTextField(
                    label: 'price',
                    onSave: (value)
                    {
                      price = int.parse(value!);
                    },
                  ),
                  CustomTextField(
                    label: 'code',
                    onSave: (value)
                    {
                      code = int.parse(value!);
                    },
                  ),
                  CustomTextField(
                    label: 'stock',
                    onSave: (value)
                    {
                      stock = int.parse(value!);
                    },
                  ),
                  CustomTextField(
                    label: 'group',
                    onSave: (value)
                    {
                      groupId = int.parse(value!);
                    },
                  ),
                  TextButton(
                    onPressed: ()
                    async {
                      itemFormKey.currentState?.save();
                      DatabaseHelper().insertItem(itemName, imageUrl, price, stock, code, groupId);
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
