import 'package:flutter/material.dart';

class PageTiket extends StatefulWidget {
  const PageTiket({super.key});

  @override
  State<PageTiket> createState() => _PageTiketState();
}

class _PageTiketState extends State<PageTiket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Silakan Ambil Tiket Anda'),
            SizedBox(height: 10),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    'PUSKESMAS DAERAH',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 20,
                    indent: 16,
                    endIndent: 16,
                  ),
                  // SizedBox(height: 10,),
                  SizedBox(height: 10),
                  Text('Poli Gizi'),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 218, 211, 211),
                      ),
                      color: const Color.fromARGB(255, 218, 211, 211),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'C-001',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('22-01-2026 12:13'),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 20,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Text('Terima Kasih'),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text(
                    'Pilih Printer',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 106, 208, 109),
                  ),
                  icon: Icon(Icons.bluetooth_audio, color: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text(
                    'CETAK',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 106, 159, 202),
                  ),
                  icon: Icon(Icons.print, color: const Color.fromARGB(255, 191, 218, 224)),
                ),
                
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'KEMBALI KE MENU',
                style: TextStyle(
                  color: const Color.fromARGB(255, 134, 189, 226),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
