import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:psut/models/api.dart';
import 'package:psut/widgets/form.dart';


class Create extends StatefulWidget {
  const Create({ Key? key }) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nisnController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController tplahirController = new TextEditingController();
  TextEditingController tglahirController = new TextEditingController();
  TextEditingController kelaminController = new TextEditingController();
  TextEditingController agamaController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();

  Future createSw() async{
    return await http.post(
      Uri.parse(BaseURL.tambah),
      body: {
        "nisn": nisnController.text,
        "nama": namaController.text,
        "tplahir": tplahirController.text,
        "tglahir": tglahirController.text,
        "kelamin": kelaminController.text,
        "agama": agamaController.text,
        "alamat": alamatController.text,
      }
    );
  }

  /*
  void onConfirm(context) async{
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }
  }
  */

  void onConfirm(context) async {
  http.Response response = await createSw();
  print("Response Body: ${response.body}"); // Debugging
  
  try {
    final data = json.decode(response.body); // Parsing JSON
    if (data['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }
  } catch (e) {
    print("JSON Parsing Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Terjadi kesalahan: ${response.body}"))
    );
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Simpan"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              print("Ok Sukses");
              onConfirm(context);
            }
          }
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: MyForm(
              formKey: formKey,
              nisnController: nisnController,
              namaController: namaController,
              tplahirController: tplahirController,
              tglahirController: tglahirController,
              kelaminController: kelaminController,
              agamaController: agamaController,
              alamatController: alamatController,
            ),
          ),
        ),
      ),
    );
  }
}