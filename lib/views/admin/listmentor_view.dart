import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/mentor_controller.dart';
import 'package:flutter_application_1/models/mentor.dart';
import 'package:flutter_application_1/views/admin/tambahmentor_view.dart';

class ListmentorView extends StatefulWidget {
  ListmentorView({Key? key}) : super(key: key);

  @override
  _ListmentorViewState createState() => _ListmentorViewState();
}

class _ListmentorViewState extends State<ListmentorView> {
  final Mentorcontroller _mentorController = Mentorcontroller();

  late Future<List<Mentor>> _mentorsFuture;

  @override
  void initState() {
    super.initState();
    _mentorsFuture = _mentorController.getMentors();
  }

  void _deleteMentor(String id) async {
    await _mentorController.deleteMentor(id);
    setState(() {
      _mentorsFuture = _mentorController.getMentors();
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
          'List Mentor',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF88A65),
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Mentor>>(
        future: _mentorsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Terjadi kesalahan"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final mentors = snapshot.data ?? [];

          return ListView.builder(
            itemCount: mentors.length,
            itemBuilder: (context, index) {
              var mentor = mentors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(mentor.fotoUrl),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mentor.nama,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      mentor.nohp,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFF8A083),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, mentor.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahmentorView()),
          );
        },
        backgroundColor: const Color(0xFFF88A65),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Konfirmasi Hapus",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: const Text(
            "Apakah Anda ingin menghapus mentor ini?",
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.redAccent, fontFamily: 'Poppins'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Ya",
                style: TextStyle(color: Colors.greenAccent, fontFamily: 'Poppins'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteMentor(id);
              },
            ),
          ],
        );
      },
    );
  }
}