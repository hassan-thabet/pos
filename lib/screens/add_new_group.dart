import 'package:flutter/material.dart';
import 'package:uptime_code/database/database_helper.dart';
import '../widgets/custom_text_field.dart';


class AddNewGroup extends StatelessWidget {
  const AddNewGroup({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String groupName = '';
    GlobalKey<FormState> groupFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new group'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
          child: Form(
            key: groupFormKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'group name',
                  isValid: (value){
                    if (value.isEmpty) {
                      return 'Enter a valid group name!';
                    }
                    return null;
                  },
                  onSave: (value)
                  {
                    groupName = value!;
                  },
                ),
                TextButton(
                  onPressed: ()

                  async {

                    final isValid = groupFormKey.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    groupFormKey.currentState?.save();
                    DatabaseHelper().insertGroup(groupName);
                    groupFormKey.currentState?.reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$groupName Added successfully') , backgroundColor: Colors.green[800],)
                    );
                  },
                  child: const Text('Add New Group'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
