import 'dart:convert';

import 'package:booking_loker/tambah_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanBooking extends StatefulWidget {
  const HalamanBooking({super.key});

  @override
  State<HalamanBooking> createState() => _HalamanBookingState();
}

class _HalamanBookingState extends State<HalamanBooking> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata()async{
    try {
      final respon = 
        await http.get(Uri.parse('http://192.168.0.102/api_booking/read.php'));
        if(respon.statusCode==200){
          final data = jsonDecode(respon.body);
          setState(() {
            _listdata = data;
            _loading = false;
          });
        }
    } catch (e) {
      print(e);
    }
  }

void initState(){
  _getdata();
  super.initState();


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Booking'),
        backgroundColor: Colors.green,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      )
      :ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index){
          return Card(
            child: ListTile(
              title: Text(_listdata[index]['kode_loker']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_listdata[index]['nama_pemesan']),
                  Text(_listdata[index]['nomer_telpon'] ?? 'Nomor Telepon Tidak Tersedia'),
                  Text(_listdata[index]['tanggal_booking'] ?? 'Tanggal Booking Tidak Tersedia'),

                ],
              ),
            ),
          );
        }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+',
        style: TextStyle(fontSize: 24),),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)
        =>TambahData()));
      }),
    );
  }
}