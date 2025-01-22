import 'package:flutter/material.dart';
import 'package:task_management/services/auth_services.dart';
import 'package:task_management/widgets/completed_widget.dart';
import 'package:task_management/widgets/pending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _buttonindex = 0;
  final _widget = [
    const PendingWidget(),
    const CompletedWidget(),
  ];
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade200,
        foregroundColor: Colors.black,
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _buttonindex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonindex == 0
                          ? Colors.blue.shade400
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                            fontSize: _buttonindex == 0 ? 18 : 14,
                            fontWeight: FontWeight.w500,
                            color: _buttonindex == 0
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _buttonindex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonindex == 1
                          ? Colors.blue.shade400
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                            fontSize: _buttonindex == 1 ? 18 : 14,
                            fontWeight: FontWeight.w500,
                            color: _buttonindex == 1
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _widget[_buttonindex],
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: MediaQuery.of(context).size.width/1.5,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/addtask');
          },
          label: const Text("Add new Task",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
          elevation: 5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
