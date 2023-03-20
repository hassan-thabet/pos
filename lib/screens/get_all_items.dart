import 'package:flutter/material.dart';
import 'package:uptime_code/core/device_size.dart';
import '../database/database_helper.dart';

class GetAllItems extends StatelessWidget {
  final List<Map> groups;
  final List<Map> items;
  const GetAllItems({Key? key, required this.groups, required this.items}) : super(key: key);

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
              itemCount: groups.length,
              separatorBuilder: (context , index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              itemBuilder: (context , index) {
                final List<Map> groupItems = items.where((element) => element['group_id'] == groups[index]['id']).toList();
                // log('group id = ${groups[index]['id']}');
                // log('${groupItems[0]['price']} EGP');
                // log(groupItems.toString());

                return SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14 , horizontal: 12),
                        child: Row(
                          children: [
                            CircleAvatar(child: Text('${index+1}')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Group Name : ${groups[index]['name']}'),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
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

                              rows:
                                List.generate( groupItems.length , (element) => DataRow(cells: [
                                  DataCell(Text('$element')),
                                  DataCell(SizedBox(width: 40 , height: 40,child: (CircleAvatar(backgroundImage: NetworkImage(groupItems[element]['image']), radius: 40,)))),
                                  DataCell(Text('${groupItems[element]['group_id']}')),
                                  DataCell(Text(groupItems[element]['name'])),
                                  DataCell(Text('# ${groupItems[element]['name']}')),
                                  DataCell(Text('${groupItems[element]['price']} EGP')),
                                  DataCell(Text('${groupItems[element]['stock']}')),
                                  DataCell(Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(right: 4),
                                          child:  InkWell(
                                              onTap: () async {
                                                DatabaseHelper().deleteItem(groupItems[element]['id']);
                                                List<Map> groups = await DatabaseHelper().getGroups();
                                                await DatabaseHelper().getItems().then((value) {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetAllItems(groups: groups, items: value)));
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('${groupItems[element]['name']} deleted successfully') , backgroundColor: Colors.red,)
                                                  );
                                                });

                                              },
                                              child: const Icon(Icons.delete , color: Colors.red,))
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(4),
                                          child:  InkWell(onTap: (){},child: const Icon(Icons.settings , color: Colors.blue,))
                                      )
                                    ],
                                  ),),
                                ]))

                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        )
    );
  }
}
