import 'package:flutter/material.dart';
class GroupListTile extends StatelessWidget {
  final String leading;
  final String title;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const GroupListTile({Key? key, required this.leading, required this.title, required this.onDelete, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(

        leading: Text(leading),
        title: Text(title),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child:  InkWell(onTap: onDelete,child: const Icon(Icons.delete , color: Colors.red,))
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child:  InkWell(onTap: onUpdate,child: const Icon(Icons.settings , color: Colors.blue,))
              )
            ],
          ),
        ),
      ),
    );
  }
}
