import 'package:booyah/antrian/page_tiket2.dart';
import 'package:flutter/material.dart';

import 'package:booyah/antrian/main.dart';
import 'package:booyah/antrian/model_layanan.dart';

class Konfirmasi extends StatelessWidget {
  final Layanan layanan;
  //Fungsi Auto Increment
  String _generateNomorAntrian(){
    int NomorSaatIni = nomorAntrian[layanan.kode] ?? 0;
    int NomorBaru = NomorSaatIni + 1;
    return '${layanan.kode} - ${NomorBaru.toString().padLeft(3,'0')}';
  }

  const Konfirmasi({
    Key? key,
    required this.layanan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String nomorTiket = _generateNomorAntrian();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Halaman Konfirmasi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.airplane_ticket_sharp,
            size: 40,
            color: Colors.amber,
            ),
            SizedBox(height: 10,),
            Text('Apakah Anda Yakin Ingin Mengantri Di'),
            SizedBox(height: 10,),
            Text(layanan.nama,
            style: TextStyle(color: Colors.blueAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text('Nomor Antrian Anda'),
                  SizedBox(height: 10,),
                  Text(nomorTiket,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 ElevatedButton(onPressed: () {
                   Navigator.pop(context);
                 }, child: Text('Batal',
                 style: TextStyle(color: Colors.white),
                 ),
                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                 ),
                 ElevatedButton(onPressed: () {
                   //Update Data
                   nomorAntrian[layanan.kode] = (nomorAntrian[layanan.kode] ?? 0) + 1;
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PageTiket2(layanan: layanan, nomorAntrian: nomorTiket),));
                 }, child: Text('Sudah Selesai',
                    style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                 )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
