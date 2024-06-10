import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/artikel_controller.dart';
import 'package:flutter_application_1/models/artikel.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';
import 'package:image_picker/image_picker.dart';

class TambahartikelView extends StatefulWidget {
  @override
  _TambahartikelViewState createState() => _TambahartikelViewState();
}

class _TambahartikelViewState extends State<TambahartikelView> {
  final ArtikelController _artikelController = ArtikelController();
  File? _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _judulController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _artikelController.pickImage(source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gambar wajib diisi'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      // Form is valid and image is selected, save artikel
      Artikel artikel = Artikel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: '',
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
      );
      _artikelController.tambahArtikel(artikel, _imageFile);
      // Clear form fields
      _judulController.clear();
      _deskripsiController.clear();
      setState(() {
        _imageFile = null;
      });

      // Navigate back to NavbarAdmin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavbarAdmin()),
      );
    }
  }

  Widget _buildImagePickerRow() {
    return Row(
      children: [
        _imageFile != null
            ? Image.file(
                _imageFile!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.image,
                size: 50,
              ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(30, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xFFF8A083),
          ),
          child: const Text(
            'Pilih Gambar',
            style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NavbarAdmin()),
            );
          },
        ),
        title: const Text(
          'Tambah Artikel',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF88A65),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Judul Artikel*',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _judulController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul artikel harus diisi';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Masukkan judul artikel',
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const Text(
                'Deskripsi*',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _deskripsiController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi artikel harus diisi';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Masukkan deskripsi artikel',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 20),
              _buildImagePickerRow(),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(340, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color(0xFFF8A083),
                  ),
                  child: const Text(
                    'Selesai',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
