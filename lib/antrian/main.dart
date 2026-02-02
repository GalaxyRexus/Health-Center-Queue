import 'package:booyah/antrian/page_menu.dart';

import 'package:flutter/material.dart';

void main(){
  runApp(Antrian());
}

class Antrian extends StatelessWidget {
  const Antrian({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Antrian Puskesnas',
      home:MenuLayanan(),
    ); 
  }
}

final Map<String, int> nomorAntrian = {'A':0, 'B':0,'C':0,'D':0};