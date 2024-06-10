import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/aduan.dart';

class DetailaduanView extends StatelessWidget {
  final Aduan aduan;

  const DetailaduanView({Key? key, required this.aduan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Detail Aduan',
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFFE87C5F)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network('${aduan.imageUrl}'),
              ),
              const SizedBox(height: 20),
              _buildDetailCard('Jenis Pelecehan', aduan.jenisPelecehan),
              const SizedBox(height: 20),
              _buildDetailCard(
                'Tanggal Kejadian',
                '${aduan.tanggalKejadian.day} ${_getMonthName(aduan.tanggalKejadian.month)} ${aduan.tanggalKejadian.year}',
              ),
              const SizedBox(height: 20),
              _buildDescriptionCard('Deskripsi', aduan.kronologi),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, String content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(String title, String content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return monthNames[month - 1];
  }
}
