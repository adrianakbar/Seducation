import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/aduan_controller.dart';
import 'package:flutter_application_1/controllers/profil_controller.dart';
import 'package:flutter_application_1/models/aduan.dart';
import 'package:intl/intl.dart';

class ListaduanView extends StatefulWidget {
  ListaduanView({Key? key}) : super(key: key);

  @override
  _ListaduanView createState() => _ListaduanView();
}

class _ListaduanView extends State<ListaduanView> {
  final AduanController _controller = AduanController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0E5),
        automaticallyImplyLeading: false,
        title: const Text(
          'List Laporan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE87C5F),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Aduan>>(
        stream: _controller.getAllAduan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Tidak ada laporan aduan saat ini'));
          } else {
            List<Aduan> aduanList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: aduanList.length,
              itemBuilder: (context, index) {
                Aduan aduan = aduanList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE87C5F)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: Color(0xFFE87C5F)),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(aduan.tanggalKejadian),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_pin,
                                color: Color(0xFFE87C5F)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                aduan.lokasi,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kronologi:',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF88A65),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          aduan.kronologi,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        aduan.imageUrl!.isNotEmpty
                            ? Image.network('${aduan.imageUrl}')
                            : Container(),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _handleLogout(context);
        },
        backgroundColor: const Color(0xFFE87C5F),
        child: const Icon(Icons.logout, color: Colors.white),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    final profilController = ProfilController();
    profilController.logout(context);
  }
}
