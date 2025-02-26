import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:async';
import 'package:psut/models/api.dart';
import 'package:psut/models/msiswa.dart';
import 'package:psut/widgets/form.dart';

class Edit extends StatefulWidget {
  final SiswaModels sw;
  Edit({required this.sw});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nisnController, namaController, tplahirController, tglahirController, 
  kelaminController, agamaController, alamatController;

  Future editsw() async {
    return await http.post(
      Uri.parse(BaseURL.update),
      body: {
        "id" : widget.sw.id.toString(),
        "nisn" : nisnController.text,
        "nama" : namaController.text,
        "tplahir" : tplahirController.text,
        "tglahir" : tglahirController.text,
        "kelamin" : kelaminController.text,
        "agama" : agamaController.text,
        "alamat" : alamatController.text,
      }
    );
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

  /*
  void onConfirm(context) async{
    http.Response response = await editsw();
    final data = json.decode(response.body);
    if(data['success']){
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil
      ('/', (Route<dynamic> route) => false);
    }
  }
  */
  void onConfirm(BuildContext context) async {
  try {
    http.Response response = await editsw();
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('success') && data['success']) {  // ✅ Pastikan kunci 'success' ada
        pesan();
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        Fluttertoast.showToast(
          msg: "Update gagal, cek kembali data!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan server (${response.statusCode})",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  void initState() {
    nisnController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tplahirController = TextEditingController(text: widget.sw.tplahir);
    tglahirController = TextEditingController(text: widget.sw.tglahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            )
          ),
          onPressed: () { onConfirm(context);}
          ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
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
    );
  }
}