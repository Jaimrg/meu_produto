// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meu_produto/constants.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:location/location.dart';
import 'package:meu_produto/screens/product_screen.dart';

class MapShow extends StatefulWidget {
  const MapShow({super.key});

  @override
  State<MapShow> createState() => _MapShowState();
}

class _MapShowState extends State<MapShow> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back),
            title: Text('Mapa e Detalhes do Produto'),
            backgroundColor: kPrimaryColor,
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    bottom: (MediaQuery.of(context).size.height * 2) / 3),
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: (MediaQuery.of(context).size.height * 1) / 3,
                    right: 16.0,
                    left: 16.0),
                child: Card(
                  margin: EdgeInsets.all(12),
                  elevation: 4,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        'assets/images/iphone.jpg')))),
                        // Spacer(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <Widget>[
                              Text("Iphone 13",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(
                                  "Telefone de 16GB de Ram e 4 cameras de 140MP",
                                  style: TextStyle(color: Colors.black)),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                  //padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Confirmação'),
                                    content: const Text('Confirma a compra?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'Cancelar');
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ArtSweetAlert.show(
                                              context: context,
                                              artDialogArgs: ArtDialogArgs(
                                                  type:
                                                      ArtSweetAlertType.success,
                                                  title: "Sucesso!",
                                                  text:
                                                      "Compra efectuada com sucesso"));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductScreen()),
                                          );
                                        },
                                        child: const Text('Sim'),
                                      ),
                                    ],
                                  ),
                                ),
                                icon: Icon(Icons.shopping_cart),
                                label: const Text('Comprar'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: (MediaQuery.of(context).size.height * 1) / 3,
              //       right: 16.0,
              //       left: 16.0),
              //   child: Container(
              //     height: 250,
              //     child: Stack(
              //       // ignore: prefer_const_literals_to_create_immutables
              //       children: [
              //         Positioned(
              //             top: 35,
              //             left: 20,
              //             child: Material(
              //               child: Container(
              //                 height: 200,
              //                 width: MediaQuery.of(context).size.width * 0.9,
              //                 decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(0.0),
              //                     boxShadow: [
              //                       BoxShadow(
              //                           color: Colors.grey.withOpacity(0.3),
              //                           offset: Offset(-10.0, 10.0),
              //                           blurRadius: 20.0,
              //                           spreadRadius: 4.0)
              //                     ]),
              //               ),
              //             )),
              //         Positioned(
              //             right: 200,
              //             top: 28,
              //             child: Card(
              //               elevation: 10.0,
              //               shadowColor: Colors.grey.withOpacity(0.5),
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(15.0),
              //               ),
              //               child: Container(
              //                 height: 180,
              //                 width: 180,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10.0),
              //                     image: DecorationImage(
              //                         fit: BoxFit.fill,
              //                         image: AssetImage(
              //                             'assets/images/iphone.jpg'))),
              //               ),
              //             )),
              //         Positioned(
              //           top: 45,
              //           left: 160,
              //           child: Container(
              //             height: 200,
              //             width: 180,
              //             child: Column(
              //               children: [
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.only(
              //                       right: 16.0,
              //                       left: 16.0),
              //                   child: Text("Iphone 13",
              //                       style: TextStyle(fontSize: 16)),
              //                 ),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                     "Telefone de 16GB de Ram e 4 cameras de 140MP",
              //                     style: TextStyle(fontSize: 16)),
              //                 TextButton(
              //                   style: TextButton.styleFrom(
              //                     foregroundColor: Colors.white,
              //                     //padding: const EdgeInsets.all(16.0),
              //                     textStyle: const TextStyle(fontSize: 20),
              //                   ),
              //                   onPressed: () {},
              //                   child: const Text('Gradient'),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
