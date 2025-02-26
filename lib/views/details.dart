import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:psut/models/api.dart';
import 'package:psut/models/msiswa.dart';
import 'package:psut/views/edit.dart';

class Details extends StatefulWidget {
  final SiswaModels sw;
  Details({required this.sw});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteSiswa(context) async{
    http.Response response = await http.post(
      Uri.parse(BaseURL.delete),
      body: {
        "id" : widget.sw.id.toString(),
      }
    );
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }
  }

  pesan(){
    Fluttertoast.showToast(
      msg: "Penghapusan Data Behasil di Simpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  void confirmDelete(context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          content: Text('Apakah anda yakin ingin menghapus data ini?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Icon(Icons.cancel)
            ),
            ElevatedButton(
              onPressed: () => deleteSiswa(context), 
              child: Icon(Icons.check_circle)
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context), 
            icon: Icon(Icons.delete)
        )
        ],
      ),
      body: Container(
        height: 270,
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Nisn : ${widget.sw.nis}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Nama : ${widget.sw.nama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Tempat Lahir : ${widget.sw.tplahir}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Tanggal Lahir : ${widget.sw.tglahir}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Kelamin : ${widget.sw.kelamin}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Agama : ${widget.sw.agama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Alamat : ${widget.sw.alamat}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => Edit(sw: widget.sw),
            )
          );
        }
      ),
    );
  }
}