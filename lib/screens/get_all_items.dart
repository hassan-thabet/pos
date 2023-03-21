import 'package:flutter/material.dart';
import 'package:uptime_code/core/device_size.dart';
import 'package:uptime_code/screens/update_item.dart';
import '../database/database_helper.dart';

class GetAllItems extends StatefulWidget {
  final List<Map> groups;
  final List<Map> items;
  const GetAllItems({Key? key, required this.groups, required this.items})
      : super(key: key);

  @override
  State<GetAllItems> createState() => _GetAllItemsState();
}

class _GetAllItemsState extends State<GetAllItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(' all Items '),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: 100.w,
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.groups.length,
                separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                itemBuilder: (context, index) {
                  final List<Map> groupItems = widget.items
                      .where((element) =>
                          element['group_id'] == widget.groups[index]['id'])
                      .toList();
                  // log('group id = ${groups[index]['id']}');
                  // log('${groupItems[0]['price']} EGP');
                  // log(groupItems.toString());

                  return SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 12),
                          child: Row(
                            children: [
                              CircleAvatar(child: Text('${index + 1}')),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Group Name : ${widget.groups[index]['name']}'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    columnSpacing: 20,
                                    columns: const [
                                      DataColumn(label: Text('index')),
                                      DataColumn(label: Text('image')),
                                      DataColumn(label: Text('group id')),
                                      DataColumn(label: Text('name')),
                                      DataColumn(label: Text('code')),
                                      DataColumn(label: Text('price')),
                                      DataColumn(label: Text('in stock')),
                                      DataColumn(label: Text('actions')),
                                    ],
                                    rows: List.generate(
                                        groupItems.length,
                                        (element) => DataRow(cells: [
                                              DataCell(Text('${element + 1}')),
                                              // DataCell(SizedBox(width: 40 , height: 40,child: (CircleAvatar(backgroundImage: NetworkImage(groupItems[element]['image'] , ), radius: 40,)))),
                                              DataCell(SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: FadeInImage(
                                                              placeholder:
                                                                  const AssetImage(
                                                                      "assets/placeholder.jpeg"),
                                                              image:
                                                                  NetworkImage(
                                                                groupItems[
                                                                        element]
                                                                    ['image'],
                                                              )).image)),
                                                ),
                                              )),

                                              DataCell(Text(
                                                  '${groupItems[element]['group_id']}')),
                                              DataCell(Text(
                                                  groupItems[element]['name'])),
                                              DataCell(Text(
                                                  '# ${groupItems[element]['code']}')),
                                              DataCell(Text(
                                                  '${groupItems[element]['price']} EGP')),
                                              DataCell(Text(
                                                  '${groupItems[element]['stock']}')),
                                              DataCell(
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 4),
                                                        child: InkWell(
                                                            onTap: () async {
                                                              DatabaseHelper()
                                                                  .deleteItem(
                                                                      groupItems[
                                                                              element]
                                                                          [
                                                                          'id']);
                                                              List<Map> groups =
                                                                  await DatabaseHelper()
                                                                      .getGroups();
                                                              await DatabaseHelper()
                                                                  .getItems()
                                                                  .then(
                                                                      (value) {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => GetAllItems(
                                                                            groups:
                                                                                groups,
                                                                            items:
                                                                                value)));
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      '${groupItems[element]['name']} deleted successfully'),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ));
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ))),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        child: InkWell(
                                                            onTap: () async {
                                                              await DatabaseHelper()
                                                                  .getGroups()
                                                                  .then(
                                                                      (value) {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => UpdateItem(
                                                                            groups:
                                                                                value,
                                                                            item:
                                                                                groupItems[element])));
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.settings,
                                                              color:
                                                                  Colors.blue,
                                                            )))
                                                  ],
                                                ),
                                              ),
                                            ]))),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ));
  }
}
