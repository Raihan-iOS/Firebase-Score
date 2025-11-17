import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  List<StudentModel> _matchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Info"),
        // actions: [
        //   IconButton(onPressed: (){
        //     FirebaseAuth.instance.signOut();
        //   }, icon: const Icon(Icons.logout))
        // ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context,snapshots) {
          if(snapshots.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshots.hasError){
            return const Center(child: Text('Something went wrong'),);
          }
          else if(snapshots.hasData){
            _matchList.clear();
               for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.data!.docs) {
              _matchList.add(StudentModel(
                  id: doc.id,
                  name: doc.get('name') ,
                  rollNumber: doc.get('rollNumber '),
                  course: doc.get('course')
              ));
            }
            return ListView.builder(
                itemCount: _matchList.length,
                itemBuilder: (context, index) {
                  final student = _matchList[index];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.green,
                    child: Text(
                      '${index+1}',
                      style: TextStyle(color: Colors.white),
                    )),
                    title: Text('Student Name:  ${student.name} '),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Roll Number: ${student.rollNumber}'),
                        Text('Course: ${student.course}'),
                      ],
                    ),
                  );
                });


          }
            return const Center(child: Text('No data found'),);

        }
      ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     FirebaseFirestore.instance.collection('football').doc('usavsiran').set({
        //       'is_running': true,
        //       'team1_name': 'USA',
        //       'team1_score': 2,
        //       'team2_name': 'China',
        //       'team2_score': 5,
        //       'winner_team': 'Iran',
        //     });
        //   },
        //   child: const Icon(Icons.add),
        // )
    );
  }

}

class StudentModel {
  final String id;
  final String name;
  final int rollNumber;
  final String course;


  StudentModel({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.course,

  });

}
