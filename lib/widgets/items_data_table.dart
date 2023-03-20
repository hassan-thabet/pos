import 'package:flutter/material.dart';
class ItemsDatatable extends StatelessWidget {
  final int index , groupId , code , price , stock ;
  final String name , image , groupName ;
  const ItemsDatatable({Key? key, required this.index, required this.groupId, required this.code, required this.price, required this.stock, required this.name, required this.image, required this.groupName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('$groupName'),
          ],
        ),
        const SizedBox(height: 20,),
        DataTable(
            columns: const [
              DataColumn(label: Text('index')),
              DataColumn(label: Text('image')),
              DataColumn(label: Text('group id')),
              DataColumn(label: Text('name')),
              DataColumn(label: Text('code')),
              DataColumn(label: Text('price')),
              DataColumn(label: Text('in stock')),
            ],

            rows: [
              DataRow(cells: [
                DataCell(Text('$index')),
                DataCell((CircleAvatar(backgroundImage: NetworkImage(image), radius: 50,))),
                DataCell(Text('$groupId')),
                DataCell(Text(name)),
                DataCell(Text('# $code')),
                DataCell(Text('$price EGP')),
                DataCell(Text('$stock')),
              ])
            ],
        ),
      ],
    );
  }
}
