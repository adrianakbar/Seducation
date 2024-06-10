import 'package:cloud_firestore/cloud_firestore.dart';

class Mentor {
  String? id;
  String nama;
  String fotoUrl;
  String nohp;
  String asal;
  String deskripsi;

  Mentor({
    this.id,
    required this.nama,
    required this.fotoUrl,
    required this.nohp,
    required this.asal,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'fotoUrl': fotoUrl,
    };
  }

  factory Mentor.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mentor(
      id: doc.id,
      nama: data['nama'],
      fotoUrl: data['fotoUrl'],
      nohp: data['nohp'],
      asal: data['asal'],
      deskripsi: data['deskripsi'],
    );
  }
}
