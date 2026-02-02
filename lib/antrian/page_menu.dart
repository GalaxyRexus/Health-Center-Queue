import 'package:booyah/antrian/model_layanan.dart';
import 'package:booyah/antrian/page_konfirmasi.dart';
import 'package:flutter/material.dart';

class MenuLayanan extends StatelessWidget {
  const MenuLayanan({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Aplikasi Antrian Puskesmas'))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: dataLayanan.length,
          itemBuilder: (context, index) {
            final layanan = dataLayanan[index];
            return Card(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Konfirmasi(layanan: layanan),));
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: layanan.warna.withOpacity(0.1),
                        radius: 30,
                        child: Icon(
                          layanan.ikon,
                          size: 35,
                          color: layanan.warna,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(layanan.nama),
                      Text(layanan.keterangan),
                    ],
                  ),
                ),

              ),
            );
          },
        ),
      ),
    );
  }
}
