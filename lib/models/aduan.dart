// models/aduan.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Aduan {
  String? id;
  String username;
  String jenisPelecehan;
  DateTime tanggalKejadian;
  String lokasi;
  String kronologi;
  String? imageUrl;

  Aduan({
    this.id,
    required this.username,
    required this.jenisPelecehan,
    required this.tanggalKejadian,
    required this.lokasi,
    required this.kronologi,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'jenispelecehan': jenisPelecehan,
      'tanggalkejadian': tanggalKejadian,
      'lokasi': lokasi,
      'kronologi': kronologi,
      'imageUrl': imageUrl,
    };
  }

  factory Aduan.fromMap(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Aduan(
      id: doc.id,
      username: data['username'],
      jenisPelecehan: data['jenispelecehan'],
      tanggalKejadian: (data['tanggalkejadian'] as Timestamp).toDate(),
      lokasi: data['lokasi'],
      kronologi: data['kronologi'],
      imageUrl: data['imageUrl'],
    );
  }
}