import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/bloc/kategori_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:localstorage/localstorage.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final LocalStorage storage = LocalStorage('localstorage_app');
  String namaUser = '';

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

    return BlocProvider(
      create: (context) => KategoriBloc(),
      child: BlocBuilder<KategoriBloc, KategoriState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Column(
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
                                ? 'Good Day! $namaUser'
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
                        Container(
                          margin: EdgeInsets.only(top: topPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (int i = 0; i < 4; i++)
                                BlocBuilder<KategoriBloc, KategoriState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.read<KategoriBloc>().add(
                                            changeKategori(
                                                KategoriStatus.values[i]));
                                        print(KategoriStatus.values[i]);
                                      },
                                      child: Container(
                                        width: (screenWidth -
                                                2 * horizontalPadding -
                                                30) /
                                            4,
                                        height: (screenWidth -
                                                2 * horizontalPadding -
                                                30) /
                                            4,
                                        decoration: BoxDecoration(
                                          color: state.kategori ==
                                                  KategoriStatus.values[i]
                                              ? COLOR.secondaryColor
                                              : Colors.grey[300],
                                          shape: BoxShape.circle,
                                          border: state.kategori ==
                                                  KategoriStatus.values[i]
                                              ? Border.all(
                                                  color: COLOR.primaryColor,
                                                  width: 5,
                                                )
                                              : null,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/image${i + 1}.png',
                                            width: (screenWidth -
                                                    1 * horizontalPadding -
                                                    200) /
                                                4,
                                            height: (screenWidth -
                                                    1 * horizontalPadding -
                                                    200) /
                                                4,
                                            fit: BoxFit
                                                .cover, // sesuaikan dengan kebutuhan Anda
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
