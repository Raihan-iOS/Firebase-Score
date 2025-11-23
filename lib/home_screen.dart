import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<FootballMatch> _matchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Football Live Score"),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('football').snapshots(),
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
              _matchList.add(FootballMatch(
                  id: doc.id,
                  isRunning: doc.get('is_running') ,
                  team1Name: doc.get('team1_name'),
                  team1Score: doc.get('team1_score') ,
                  team2Name: doc.get('team2_name') ,
                  team2Score: doc.get('team2_score') ,
                  winnerTeam: doc.get('winner_team') ,
              ));
            }
            return ListView.builder(
                itemCount: _matchList.length,
                itemBuilder: (context, index) {
                  final footballMatch = _matchList[index];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: footballMatch.isRunning ? Colors.green : Colors.grey,radius: 8,),
                    title: Text('${footballMatch.team1Name} vs ${footballMatch.team2Name} '),
                    subtitle: Text( footballMatch.isRunning ? 'Pending': 'Winner: ${footballMatch.winnerTeam}'),
                    trailing: Text('${footballMatch.team1Score}-${footballMatch.team2Score}'),
                  );
                });


          }
            return const Center(child: Text('No data found'),);

        }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           throw Exception('Add your own data logic here');
            FirebaseFirestore.instance.collection('football').doc('usavsiran').set({
              'is_running': true,
              'team1_name': 'USA',
              'team1_score': 2,
              'team2_name': 'China',
              'team2_score': 5,
              'winner_team': 'Iran',
            });
          },
          child: const Icon(Icons.add),
        )
    );
  }

}

class FootballMatch {
  final String id;
  final bool isRunning;
  final String team1Name;
  final int team1Score;
  final String team2Name;
  final int team2Score;
  final String winnerTeam;

  FootballMatch({
    required this.id,
    required this.isRunning,
    required this.team1Name,
    required this.team1Score,
    required this.team2Name,
    required this.team2Score,
    required this.winnerTeam,
  });

}
