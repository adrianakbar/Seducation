import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/profil_controller.dart';
import 'package:flutter_application_1/models/user.dart' as model_user;
import 'package:flutter_application_1/views/user/navbar_user.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final ProfilController _profilController = ProfilController();
  model_user.User? _user; // Variabel _user diubah menjadi nullable
  late TextEditingController _usernameController;
  late TextEditingController _umurController;
  late String _selectedJenisKelamin = ''; // Menyimpan pilihan jenis kelamin
  final _formKey = GlobalKey<FormState>(); // Key untuk form
  bool _isLoading = true; // Variabel untuk status loading

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _umurController = TextEditingController();
    _loadUserData(); // Memuat data pengguna saat inisialisasi
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _umurController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final user = await _profilController.getCurrentUserData();
    setState(() {
      _user = user;
      _usernameController.text = _user!.username;
      _umurController.text = _user!.umur;
      _selectedJenisKelamin = _user!.jenisKelamin; // Set jenis kelamin default
      _isLoading = false; // Data selesai dimuat
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavbarUser()),
            );
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xFFE87C5F),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(), // Menampilkan indikator loading saat data sedang dimuat
            )
          : Center(
              child: Form(
                key: _formKey, // Menyambungkan form dengan GlobalKey
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            padding: const EdgeInsets.all(
                                3), // Padding untuk bingkai
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE87C5F),
                                width: 3,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _user!.imageUrl.isNotEmpty
                                  ? NetworkImage(_user!.imageUrl)
                                  : const AssetImage(
                                          'assets/images/Profile.png')
                                      as ImageProvider,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () async {
                                await _profilController.changeProfilePicture(
                                    context, _user!);
                                // Memanggil _loadUserData untuk memperbarui gambar profil setelah diubah
                                await _loadUserData();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _user!.email,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        _user!.username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8A083),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Username',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Color(0xFFF8A083),
                                  ),
                                  border: InputBorder.none,
                                ),
                                style:
                                    const TextStyle(color: Color(0xFFF8A083)),
                                validator: (value) {
                                  // Hapus validasi di sini
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Umur',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                controller: _umurController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Color(0xFFF8A083),
                                  ),
                                  border: InputBorder.none,
                                ),
                                style:
                                    const TextStyle(color: Color(0xFFF8A083)),
                                validator: (value) {
                                  // Hapus validasi di sini
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Jenis Kelamin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'Laki-laki',
                                  groupValue: _selectedJenisKelamin,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedJenisKelamin = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Laki-laki',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Radio<String>(
                                  value: 'Perempuan',
                                  groupValue: _selectedJenisKelamin,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedJenisKelamin = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  'Perempuan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00E6AB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_usernameController.text.isNotEmpty &&
                                        _umurController.text.isNotEmpty) {
                                      _profilController.updateUserData(
                                        _user!.id,
                                        _usernameController.text,
                                        _umurController.text,
                                        _selectedJenisKelamin,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Profil berhasil diperbarui'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Username dan umur tidak boleh kosong'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'Simpan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _profilController.logout(context);
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    color: Color(0xFFF8A083),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 30), // Menambahkan jarak sebesar 30px
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
