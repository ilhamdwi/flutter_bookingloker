import 'package:booking_loker/halaman_booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahData extends StatefulWidget {
  const TambahData({super.key});

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController  kode_loker = TextEditingController();
  TextEditingController  nama_pemesan = TextEditingController();
  TextEditingController  nomer_telpon = TextEditingController();
  DateTime? tanggal_booking;

  Future<bool?> _simpan() async {
  final respon = await http.post(
    Uri.parse('http://192.168.0.102/api_booking/create.php'),
    body: {
      'kode_loker': kode_loker.text,
      'nama_pemesan': nama_pemesan.text,
      'nomer_telpon': nomer_telpon.text,
      'tanggal_booking': tanggal_booking?.toString() ?? '',
    },
  );

  if (respon.statusCode == 200) {
    return true;
  } else {
    // Jika kode statusnya bukan 200, kembalikan null.
    return null;
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: kode_loker,
                decoration: InputDecoration(
                  hintText: 'Kode Loker',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Kode Loker tidak boleh kosong!";
                    }
                  },
              ),
              TextFormField(
                controller: nama_pemesan,
                decoration: InputDecoration(
                  hintText: 'Nama Pemesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Nama Pemesan tidak boleh kosong!";
                    }
                  },
              ),
              TextFormField(
                controller: nomer_telpon,
                decoration: InputDecoration(
                  hintText: 'Nomer Telepon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                  )),
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Nomer Telepon tidak boleh kosong!";
                    }
                  },
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  ).then((pickedDate) {
                    if (pickedDate != null) {
                      setState(() {
                        tanggal_booking = pickedDate;
                      });
                    }
                  });
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: tanggal_booking == null
                      ? ''
                      : "${tanggal_booking!.year}-${tanggal_booking!.month.toString().padLeft(2, '0')}-${tanggal_booking!.day.toString().padLeft(2, '0')}",
                    ),
                    decoration: InputDecoration(
                      hintText: 'Tanggal Booking',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Tanggal Booking tidak boleh kosong!";
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                onPressed: (){
                if(formKey.currentState!.validate()){
                  try {
                  _simpan().then((value){
                    if(value != null && value){
                      final snackBar = SnackBar(content:  Text('Data Behasil Disimpan'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else {
                       final snackBar = SnackBar(content:  Text('Data Gagal Disimpan'),);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                  Navigator.pushAndRemoveUntil(
                   context,
                    MaterialPageRoute(
                      builder: ((context) => HalamanBooking())),
                      (route) => false,
                      );
                  } catch(e) {
                    print('Error : $e');
                  }
                }
              }, child: Text('Simpan'))
            ],
          ),
        ),),
    );
  }
}