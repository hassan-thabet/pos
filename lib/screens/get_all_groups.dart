import 'package:flutter/material.dart';
import 'package:uptime_code/core/device_size.dart';
import 'package:uptime_code/database/database_helper.dart';
import 'package:uptime_code/widgets/group_list_tile.dart';
class GetAllGroups extends StatelessWidget {
  final List<Map> groups;
  const GetAllGroups({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' all groups '),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 100.w,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groups.length,
            separatorBuilder: (context , index) => const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(),
            ),
            itemBuilder: (context , index) =>
                GroupListTile(
                  leading: '${index+1}',
                  title: '${groups[index]['name']} group id is : ${groups[index]['id']}',
                  onDelete: () async {
                    DatabaseHelper().deleteGroup(groups[index]['id']);
                    await DatabaseHelper().getGroups().then((value) {

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetAllGroups(groups: value)));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${groups[index]['name']} deleted successfully') , backgroundColor: Colors.red,)
                      );
                    });
                  },
                  onUpdate: () {  },
                ),
          ),
        ),
      )
    );
  }
}
