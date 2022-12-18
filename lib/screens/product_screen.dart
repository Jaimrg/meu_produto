// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meu_produto/auth_service.dart';
import 'package:meu_produto/components/drawer_header.dart';
import 'package:meu_produto/model/product.dart';
import 'package:meu_produto/components/drawer_navigation_item.dart';
import 'package:meu_produto/screens/map_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//import 'package:cached_network_image/cached_network_image.dart';
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Text(
                  "Produtos",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),
            Container(),
            Positioned(
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: new Icon(Icons.menu),
                  color: Theme.of(context).primaryColor,
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                primary: false,
                title: TextField(
                    decoration: InputDecoration(
                        hintText: "Pesquisar",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey))),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart,
                        color: Theme.of(context).primaryColor),
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      );

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = [];

    for (var i = 0; i < 10; i++) {
      products.add(Product(
          description: 'IPhone 13',
          image_path: 'assets/images/iphone.jpg',
          price: 1200));
    }
    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MapShow()),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 18 / 11,
                child: CachedNetworkImage(
                  imageUrl: product.image_path,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child:
                        CircularProgressIndicator(), 
                  ), 
                  errorWidget: (context, url, error) =>
                      Image.asset(product.image_path),//("assets/images/noimage.png"),
                  
                ),
                // child: Image.asset(
                //   product.image_path,
                //   // package: product.assetPackage,
                // ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.description,
                        style: theme.textTheme.headline6,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        formatter.format(product.price),
                        style: theme.textTheme.subtitle2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      key: _scaffoldKey,
      drawer: Drawer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeaderC(),
                const SizedBox(
                  height: 16.0,
                ),
                DrawerNavigationItem(
                  iconData: Icons.person,
                  title: "Perfil",
                  onTap: () {},
                  selected: true,
                ),
                DrawerNavigationItem(
                  iconData: Icons.production_quantity_limits_rounded,
                  title: "Meus Produtos",
                  onTap: () {
                    //redirect
                  },
                  selected: false,
                ),
                DrawerNavigationItem(
                  iconData: Icons.settings,
                  title: "Definições",
                  onTap: () {
                    //redirect
                  },
                  selected: false,
                ),
                const Divider(
                  thickness: 1.0,
                ),
                DrawerNavigationItem(
                  iconData: Icons.logout,
                  title: "LogOut",
                  selected: false,
                  onTap: () {
                    AuthService().signOut();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context) // Changed code
          ),
    );
  }
}
