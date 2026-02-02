import 'package:flutter/material.dart';

class Layanan {
  final String nama;
  final String keterangan;
  final IconData ikon;
  final String kode;
  final Color warna;

  Layanan({
    required this.nama,
    required this.keterangan,
    required this.ikon,
    required this.kode,
    required this.warna,
  });
}

final List<Layanan> dataLayanan = [
  Layanan(
    nama: 'Poli Umum',
    keterangan: 'Layanan Umum',
    ikon: Icons.diversity_1,
    kode: 'A',
    warna: Colors.lightBlue!) ,
  Layanan (
    nama: 'Poli Gigi',
    keterangan: 'Layanan Gigi',
    ikon: Icons.fitbit,
    kode: 'B',
    warna: Colors.orange!) ,
  Layanan (
    nama: 'Poli Gizi',
    keterangan: 'Layanan Gizi',
    ikon: Icons.fastfood_outlined,
    kode: 'C',
    warna: Colors.green!) ,
  Layanan (
    nama: 'Laboratorium',
    keterangan: 'Layanan Lab',
    ikon: Icons.coronavirus_outlined,
    kode: 'D',
    warna: Colors.brown!) ,
];
