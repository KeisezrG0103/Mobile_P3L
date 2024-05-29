import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/bloc/kategori_bloc.dart';
import 'package:untitled/bloc/bloc_produk/blok_produk_bloc.dart';
import 'package:untitled/constant/Color.dart';
import 'package:localstorage/localstorage.dart';
import 'package:untitled/repository/repository_katalog.dart';
import 'package:untitled/ui/Customer_UI/Home/ListProduk.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final LocalStorage storage = LocalStorage('localstorage_app');
  String namaUser = '';
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    await storage.ready;
    setState(() {
      namaUser = storage.getItem('namaUser') as String? ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double horizontalPadding = screenWidth * 0.05;
    final double topPadding = screenHeight * 0.02;

    final List<String> imgList = [
      'assets/carousel-1.png',
      'assets/carousel-2.png',
      'assets/carousel-3.png',
      'assets/carousel-4.png',
      'assets/carousel-5.png',
    ];

    return RepositoryProvider(
      create: (context) => RepositoryKatalog(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => KategoriBloc(),
          ),
          BlocProvider(
            create: (context) => BlokProdukBloc()..add(GetProduk('Cake')),
          ),
        ],
        child: BlocBuilder<KategoriBloc, KategoriState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          topPadding,
                          horizontalPadding,
                          0,
                        ),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                namaUser.isNotEmpty
                                    ? 'Good Day! //'
                                    : 'Hi there',
                                style: TextStyle(
                                  color: COLOR.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Embrace our tasty treats.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: topPadding,
                        ),
                        child: buildCarousel(imgList),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          topPadding,
                          horizontalPadding,
                          0,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Our Category",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: COLOR.primaryColor,
                                ),
                              ),
                            ),
                            Kategori(
                              topPadding,
                              screenWidth,
                              horizontalPadding,
                            ),
                          ],
                        ),
                      ),
                      BlocListener<KategoriBloc, KategoriState>(
                        listener: (context, state) {
                          if (state.kategori == KategoriStatus.cake) {
                            context
                                .read<BlokProdukBloc>()
                                .add(GetProduk('Cake'));
                          } else if (state.kategori == KategoriStatus.drink) {
                            context
                                .read<BlokProdukBloc>()
                                .add(GetProduk('Minuman'));
                          } else if (state.kategori == KategoriStatus.penitip) {
                            context
                                .read<BlokProdukBloc>()
                                .add(GetProduk('penitip'));
                          } else if (state.kategori == KategoriStatus.bread) {
                            context
                                .read<BlokProdukBloc>()
                                .add(GetProduk('Roti'));
                          }
                        },
                        child: BlocConsumer<BlokProdukBloc, BlokProdukState>(
                          listener: (context, state) {
                            if (state.status == ProdukStatus.failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to fetch data'),
                                ),
                              );
                            }

                            if (state.status == ProdukStatus.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Data fetched successfully'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }

                            if (state.status == ProdukStatus.loading) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Loading data...'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(
                                  horizontalPadding,
                                  20.0,
                                  20.0,
                                  0,
                                ),
                                child: ListProduk(
                                  listProduk: state.produk,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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

  Widget buildCarousel(List<String> imgList) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          items: imgList
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Container(
                      child:
                          Image.asset(item, fit: BoxFit.cover, width: 1000.00),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentImageIndex = entry.key;
                });
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == entry.key
                      ? COLOR.primaryColor
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Container Kategori(
      double topPadding, double screenWidth, double horizontalPadding) {
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 4; i++)
            BlocBuilder<KategoriBloc, KategoriState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<KategoriBloc>()
                        .add(changeKategori(KategoriStatus.values[i]));
                  },
                  child: Container(
                    width: (screenWidth - 2 * horizontalPadding - 30) / 4,
                    height: (screenWidth - 2 * horizontalPadding - 30) / 4,
                    decoration: BoxDecoration(
                      color: state.kategori == KategoriStatus.values[i]
                          ? COLOR.secondaryColor
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                      border: state.kategori == KategoriStatus.values[i]
                          ? Border.all(
                              color: COLOR.primaryColor,
                              width: 5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/image${i + 1}.png',
                        width: (screenWidth - 1 * horizontalPadding - 200) / 4,
                        height: (screenWidth - 1 * horizontalPadding - 200) / 4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
