class Artikel {
  final String id;
  final String imageUrl;
  final String judul;
  final String deskripsi;

  Artikel(
      {required this.id,
      required this.imageUrl,
      required this.judul,
      required this.deskripsi});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'judul': judul,
      'deskripsi': deskripsi,
    };
  }
}
