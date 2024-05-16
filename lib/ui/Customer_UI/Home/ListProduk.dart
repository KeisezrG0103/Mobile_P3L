import 'package:flutter/material.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/models/Model_Katalog.dart';

class ListProduk extends StatefulWidget {
  final List<ModelKatalog> listProduk;

  ListProduk({Key? key, required this.listProduk}) : super(key: key);

  @override
  State<ListProduk> createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      itemCount: widget.listProduk.length,
      itemBuilder: (context, index) {
        return ProductItem(
          product: widget.listProduk[index],
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final ModelKatalog product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              product.gambar,
              height: 100,
              width: 100,
            ),
            SizedBox(height: 8),
            Text(
              product.nama,
              style: TextStyle(fontSize: 15, color: COLOR.primaryColor),
            ),
            Expanded(
              // Wrap the Column with Expanded
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align content to the bottom
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Rp ${product.harga}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Kuota : ${product.kuota}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
