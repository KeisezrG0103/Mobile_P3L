import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Laporan_bloc/laporan_bloc_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/repository/repository_laporan.dart';
import 'package:untitled/ui/MO_UI/Laporan/Laporan_Stok_Bahan_Baku/index.dart';

class LaporanUI extends StatelessWidget {
  const LaporanUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Laporan',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: COLOR.primaryColor,
        ),
        body: RepositoryProvider(
          create: (context) => RepositoryLaporan(),
          child: BlocProvider(
            create: (context) => LaporanBlocBloc(
              laporanRepository: RepositoryLaporan(),
            ),
            child: BlocConsumer<LaporanBlocBloc, LaporanBahanBakuBlocState>(
              listener: (context, state) {
                if (state.status == LaporanStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal memuat data'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LaporanBlocBloc>(context)
                            .add(getLaporanStokBahanBaku());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Index_Laporan_Bahan_Baku(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Laporan Stok Bahan Baku',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Laporan 2',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Laporan 3',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Laporan 4',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR.tertiaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Laporan 5',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
