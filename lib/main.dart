import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:uptime_code/core/extensions.dart';
import 'package:uptime_code/database/database_helper.dart';
import 'package:uptime_code/screens/add_new_group.dart';
import 'package:uptime_code/screens/add_new_item.dart';
import 'package:uptime_code/screens/get_all_groups.dart';
import 'package:uptime_code/widgets/custom_card_widget.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    setWindowMinSize(const Size(800, 600));
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  } else if (kIsWeb) {
    try {
      databaseFactory = databaseFactoryFfiWeb;
    } catch (e) {
      log('error from web $e');
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Uptimecode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    DatabaseHelper().createDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCardWidget(
                    title: 'Show all items',
                    onClick: () {},
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomCardWidget(
                    title: 'Show all Groups',
                    onClick: () async {
                      await DatabaseHelper().getGroups().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GetAllGroups(groups: value)));
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCardWidget(
                    title: 'Add New item',
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewItem()));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomCardWidget(
                    title: 'Add New group',
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddNewGroup()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
