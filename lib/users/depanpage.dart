import 'dart:convert'; // To decode JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/models/kategori.dart'; // Ensure correct import path
import 'package:tokoonline/constans.dart'; // Ensure Palette.sUrl is defined

class DepanPage extends StatefulWidget {
  @override
  State<DepanPage> createState() => _DepanPageState();
}

class _DepanPageState extends State<DepanPage> {
  List<Kategori> kategoriList = [];

  @override
  void initState() {
    super.initState();
    fetchKategori(); // Call the function in initState
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here, if needed
    super.dispose();
  }

  Future<void> fetchKategori() async {
    var params = "/kategoribyproduk";
    try {
      var jsonResponse = await http.get(Uri.parse(Palette.sUrl + params)); // Fixed to Palette.sUrl
      print(Palette.sUrl + params);
      print(jsonResponse.statusCode);
      if (jsonResponse.statusCode == 200) {
        final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>(); // Decode the JSON response
        
        List<Kategori> usersList = jsonItems.map<Kategori>((json) {
          return Kategori.fromJson(json); // Fixed to Kategori.fromJson
        }).toList();

        setState(() {
          kategoriList = usersList;
        });
      }
    } catch (e) {
      print("Error fetching kategori: $e");
      // Optionally handle the error
    }
  }

  Future<void> _refresh() async {
    await fetchKategori(); // Use async/await properly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              produkbyKategori(),
            ],
          ),
        ),
      ),
    );
  }

  Widget produkbyKategori() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < kategoriList.length; i++)
            WidgetbyKategori(
              kategoriList[i].id, kategoriList[i].nama.toString(), i),
        ],
      ),
    );
  }
}

class WidgetbyKategori extends StatelessWidget {
  final int id;
  final String kategori;
  final int warna;

  WidgetbyKategori(this.id, this.kategori, this.warna, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.only(right: 10.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    kategori,
                    style: const TextStyle(color: Colors.white),
                  ),
                  width: 200.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Palette.colors[warna],
                    boxShadow: [
                      BoxShadow(
                          color: Palette.colors[warna],
                          spreadRadius: 1),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.of(context)
                    //    .push(MaterialPageRoute(builder: (_) {
                    //  return ProdukPage("kat", id, 0, kategori);
                    // }));
                  },
                  child: const Text('Selengkapnya',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
