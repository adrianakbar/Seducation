import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/models/artikel.dart';
import 'package:image_picker/image_picker.dart';

class ArtikelController {
  final List<Artikel> _artikels = [];

  List<Artikel> get artikels => _artikels;

  Future<void> fetchArtikels() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('artikel').get();

    _artikels.clear();
    for (var doc in snapshot.docs) {
      _artikels.add(Artikel(
        id: doc.id, // Use doc.id to get the document ID
        imageUrl: doc['imageUrl'],
        judul: doc['judul'],
        deskripsi: doc['deskripsi'],
      ));
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<void> tambahArtikel(Artikel artikel, File? imageFile) async {
    try {
      // Upload gambar ke Firebase Storage jika ada
      if (imageFile != null) {
        final ref =
            FirebaseStorage.instance.ref().child('artikel/${artikel.judul}');
        final imageUrl = await uploadImage(ref, imageFile);
        final updatedArtikel = Artikel(
          id: artikel.id,
          imageUrl: imageUrl,
          judul: artikel.judul,
          deskripsi: artikel.deskripsi,
        );
        // Simpan data artikel ke Firestore
        await FirebaseFirestore.instance
            .collection('artikel')
            .add(updatedArtikel.toMap());
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> hapusArtikel(String artikelId, String imageUrl) async {
    try {
      // Delete artikel from Firestore
      await FirebaseFirestore.instance
          .collection('artikel')
          .doc(artikelId)
          .delete();

      // Delete image from Firebase Storage
      final ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<String> uploadImage(Reference ref, File imageFile) async {
    final uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }
}
