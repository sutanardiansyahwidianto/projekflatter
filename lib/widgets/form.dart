import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';

class MyForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nisnController;
  final TextEditingController namaController;
  final TextEditingController tplahirController;
  final TextEditingController tglahirController;
  final TextEditingController kelaminController;
  final TextEditingController agamaController;
  final TextEditingController alamatController;

  MyForm({
    required this.formKey,
    required this.nisnController,
    required this.namaController,
    required this.tplahirController,
    required this.tglahirController,
    required this.kelaminController,
    required this.agamaController,
    required this.alamatController,
  });

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  late String kelamin, agama, alamat;

  final List<String> status = ["", "Laki-laki", "Perempuan"];
  final List<String> items = [
    "",
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Khonghucu",
    "Kepercayaan"
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtNisn(),
            SizedBox(height: 16),
            txtNama(),
            SizedBox(height: 16),
            txtTplahir(),
            SizedBox(height: 16),
            txtTglahir(),
            SizedBox(height: 16),
            txtKelamin(),
            SizedBox(height: 16),
            txtAgama(),
            SizedBox(height: 16),
            txtAlamat(),
          ],
        ),
      ),
    );
  }

  Widget txtNisn() {
    return TextFormField(
      controller: widget.nisnController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "NISN",
        prefixIcon: Icon(Icons.card_membership),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukan No NISN Anda";
        }
        return null;
      },
    );
  }

  Widget txtNama() {
    return TextFormField(
      controller: widget.namaController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukan Nama Anda";
        }
        return null;
      },
    );
  }

  Widget txtTplahir() {
    return TextFormField(
      controller: widget.tplahirController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        prefixIcon: Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukan Kota Kelahiran Anda";
        }
        return null;
      },
    );
  }

  Widget txtTglahir() {
    return TextFormField(
      controller: widget.tglahirController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Tanggal Lahir",
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onTap: () async {
        DateTime? tglahir = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 150),
          lastDate: DateTime.now(),
        );

        if (tglahir != null) {
          widget.tglahirController.text = DateFormat('yyyy-MM-dd').format(tglahir);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukan Tanggal Lahir Anda";
        }
        return null;
      },
    );
  }

  Widget txtKelamin() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Kelamin",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: widget.kelaminController.text.isEmpty ? null : widget.kelaminController.text,
      hint: Text("Jenis Kelamin"),
      onChanged: (String? newValue) {
        setState(() {
          kelamin = newValue!;
          widget.kelaminController.text = kelamin;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Silakan pilih jenis kelamin Anda";
        }
        return null;
      },
      items: status.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget txtAgama() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Agama",
        prefixIcon: Icon(Icons.mosque),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      value: widget.agamaController.text.isEmpty ? null : widget.agamaController.text,
      hint: Text("Pilih Agama"),
      onChanged: (String? value) {
        setState(() {
          agama = value!;
          widget.agamaController.text = agama;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Masukan Pilih Agama Anda";
        }
        return null;
      },
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(fontSize: 14, color: Colors.blue)),
        );
      }).toList(),
    );
  }

  Widget txtAlamat() {
    return TextFormField(
      controller: widget.alamatController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Alamat",
        prefixIcon: Icon(Icons.location_on),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Masukan Alamat Anda";
        }
        return null;
      },
    );
  }
}
