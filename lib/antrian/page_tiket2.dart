import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

import 'package:booyah/antrian/model_layanan.dart';
import 'package:intl/intl.dart';

class PageTiket2 extends StatefulWidget {
  final Layanan layanan;
  final String nomorAntrian;

  const PageTiket2({
    Key? key,
    required this.layanan,
    required this.nomorAntrian,
  }) : super(key: key);

  @override
  State<PageTiket2> createState() => _PageTiket2State();
}

class _PageTiket2State extends State<PageTiket2> {
  // Inisialisasi Library Printer
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _isConnected = false;
  bool _isPrinting = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  // Mencari perangkat yang sudah dipasangkan (Bonded Devices)
  Future<void> _initBluetooth() async {
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
    setState(() {
      _devices = devices;
    });
  }

  // Menampilkan Dialog Pilih Printer
  Future<void> _selectPrinter() async {
    if (_devices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tidak ada perangkat Bluetooth yang ditemukan.',
          ),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_devices[index].name ?? "Perangkat tidak dikenali"),
              subtitle: Text(
                _devices[index].address ?? "Alamat tidak ditemukan",
              ),
              onTap: () {
                setState(() {
                  _selectedDevice = _devices[index];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Printer Dipilih: ${_selectedDevice!.name}'),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // LOGIKA CETAK MENGGUNAKAN BLUE_THERMAL_PRINTER
  Future<void> _printTicket() async {
    if (_selectedDevice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon pilih printer bluetooth terlebih dahulu.'),
        ),
      );
      return;
    }

    setState(() {
      _isPrinting = true;
    });

    try {
      // 1. Koneksi ke Printer
      await bluetooth.connect(_selectedDevice!);

      // 2. Perintah Cetak
      // printCustom(text, size, align)
      // size: 0 (kecil), 1 (sedang), 2 (besar), 3 (sangat besar)
      // align: 0 (kiri), 1 (tengah), 2 (kanan)

      bluetooth.printCustom("PUSKESMAS KELAS KING", 1, 1);
      bluetooth.printCustom("Jl.Panglima Sudirman Wahyu Said", 0, 1);

      bluetooth.printNewLine();
      bluetooth.printNewLine();

      // bluetooth.printCustom("ANTRIAN ${widget.layanan.nama}", 1, 1);
      bluetooth.printCustom("ANTRIAN ${widget.layanan.nama}", 1, 1);

      bluetooth.printNewLine();
      // Cetak nomor antrian ukuran besar di tengah
      bluetooth.printCustom(widget.nomorAntrian, 3, 1);

      bluetooth.printNewLine();
      bluetooth.printCustom("----------------------------", 0, 1);

      // Cetak Tanggal
      final now = DateTime.now();
      final formatter = DateFormat('dd-MM-yyyy HH:mm');
      bluetooth.printCustom(formatter.format(now), 0, 1);
      bluetooth.printCustom("LSP 2026 - Cendy", 0, 1);

      bluetooth.printNewLine();
      bluetooth.printCustom("Mohon menunggu panggilan...", 0, 1);

      bluetooth.printNewLine();
      bluetooth.printNewLine();
      bluetooth.printNewLine();

      // 3. Putus Koneksi
      await bluetooth.disconnect();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Mencetak!'),
          backgroundColor: Colors.green,
        ),
      );

      //memberi jeda sedikit sebelum kembali ke menu utama
      await Future.delayed(Duration(milliseconds: 800));

      //kembali ke halaman menu otomatis
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      print("Error Printing: $e");
      //jika error cetak, TIDAK kembali ke menu, harus coba cetak ulang
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mencetak: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      //memastikan tombol cetak aktif kembali
      if (mounted) {
        setState(() {
          _isPrinting = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Halaman Tiket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Silakan Ambil Tiket Anda'),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'PUSKESMAS DAERAH',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Text(widget.layanan.nama),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 235, 235),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      widget.nomorAntrian,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())),

                  Divider(),

                  Text('Terimakasih Yahaha'),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.bluetooth_audio, color: Colors.white),
                    label: Text(
                      _selectedDevice?.name ?? 'Pilih Printer',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _selectPrinter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.print_rounded, color: Colors.white),
                    label: Text('CETAK', style: TextStyle(color: Colors.white)),
                    onPressed: _isPrinting ? null:_printTicket,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              label: Text(
                'Kembali Ke Menu',
                style: TextStyle(color: Colors.lightBlue),
              ),
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst,),
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
