import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:psut/models/api.dart';
import 'package:psut/models/msiswa.dart';
import 'package:psut/views/create.dart';
import 'package:psut/views/details.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<SiswaModels>> sw;
  final swListKey = GlobalKey<_HomeState>();
  @override
  void initState(){
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModels>> getSwList() async{
    final resposne = await http.get(Uri.parse(BaseURL.list));
    // print(resposne.body);
    final items = json.decode(resposne.body).cast<Map<String, dynamic>>();
    List<SiswaModels> sw = items.map<SiswaModels>((json){
      return SiswaModels.fromJson(json);
    }).toList();
    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModels>>(
          future: sw, 
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading
            } else if (snapshot.hasError) {
              return Text("Terjadi kesalahan: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Text("Data tidak ditemukan");
            }
            //if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.nis + " " + data.nama,
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    subtitle: Text(data.tplahir + "," + data.tglahir),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Details(sw: data)
                        ));
                    },
                  ),
                );
              },
            );
          }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_){
              return Create() ;
            }
            ));
        }
        ),
    );
  }
}