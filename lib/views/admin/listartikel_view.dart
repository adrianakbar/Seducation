import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/artikel_controller.dart';
import 'package:flutter_application_1/models/artikel.dart';
import 'package:flutter_application_1/views/admin/tambahartikel_view.dart';

class ListartikelView extends StatefulWidget {
  ListartikelView({Key? key}) : super(key: key);

  @override
  _ListartikelViewState createState() => _ListartikelViewState();
}

class _ListartikelViewState extends State<ListartikelView> {
  final ArtikelController _controller = ArtikelController();

  @override
  void initState() {
    super.initState();
    _controller.fetchArtikels().then((_) {
      setState(() {}); // Refresh UI after data is fetched
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        automaticallyImplyLeading: false,
        title: const Text(
          'List Artikel',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE87C5F),
          ),
        ),
        centerTitle: true,
      ),
      body: _controller.artikels.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _controller.artikels.length,
              itemBuilder: (context, index) {
                Artikel artikel = _controller.artikels[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          artikel.imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                artikel.judul,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFE87C5F),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Hapus Artikel', style: TextStyle(fontFamily: 'Poppins'),),
                                      content: const Text(
                                          'Apakah Anda ingin menghapus artikel ini?', style: TextStyle(fontFamily: 'Poppins')),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Batal', style: TextStyle(fontFamily: 'Poppins', color: Colors.redAccent)),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _controller.hapusArtikel(
                                                artikel.id, artikel.imageUrl);
                                            // Refresh page after successful deletion
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ya', style: TextStyle(fontFamily: 'Poppins', color: Colors.greenAccent)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TambahartikelView()),
          );
        },
        backgroundColor: const Color(0xFFE87C5F),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
