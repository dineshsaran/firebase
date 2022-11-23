import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final CollectionReference users =
  FirebaseFirestore.instance.collection('users');

  Future<void> create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Age'
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  final String name = nameController.text;
                  final int age = int.parse(ageController.text);
                  if (age != null){
                    await users.add({"name":name, "age":age});

                    nameController.text='';
                    ageController.text='';
                    Navigator.of(context).pop();
                  }
                }, child: Text('Create'))
              ],
            ),
          );
        }
    );
  }

  Future<void> update([DocumentSnapshot? documentSnapshot])async{
    if(documentSnapshot != null){
      nameController.text  = documentSnapshot['name'];
      ageController.text = documentSnapshot['age'].toString();
    }
    await showModalBottomSheet(context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
      return Padding(padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            keyboardType: TextInputType.name,
            controller: ageController,
            decoration: const InputDecoration(labelText: 'Age'),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            final String name = nameController.text;
            final int age = int.parse(ageController.text.toString());

            await users.doc(documentSnapshot!.id).update({"name": name , " age": age});
            nameController.text= '';
            ageController.text = '';
            Navigator.of(context).pop();
         },
              child: Text('Update'))

        ],
      ),);
        });

  }

  Future<void> delete(String userId) async {
    await users.doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('You have successfully deleted a user')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
      ),
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['age'].toString()),
                      subtitle: Text(documentSnapshot['name']),
                      trailing: SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                 update(documentSnapshot);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                                onPressed: () {
                                  delete(documentSnapshot.id);
                                }, icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

      ),

floatingActionButton: FloatingActionButton(
  onPressed: (){
    create();
  },
  child: Icon(Icons.add),
),
    );
  }
}
