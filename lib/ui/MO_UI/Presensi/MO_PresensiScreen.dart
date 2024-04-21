import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Get_Presensi_bloc/get_presensi_bloc.dart';
import 'package:untitled/models/Model_Presensi.dart';
import 'package:intl/intl.dart';
import 'package:untitled/constant/color.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PresensiSuccess extends StatefulWidget {
  List<Presensi> presensi;

  PresensiSuccess({Key? key, required this.presensi}) : super(key: key);

  @override
  State<PresensiSuccess> createState() => _PresensiSuccessState();
}

class _PresensiSuccessState extends State<PresensiSuccess> {
  DateTime? selectedDate = DateTime.now();

  List<Presensi> _getFilteredPresensi() {
    String selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate!);
    return widget.presensi
        .where((presensi) => presensi.Tanggal == selectedDateString)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChangeToTidakHadirBloc, ChangeToTidakHadirState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<GetPresensiBloc>().add(GetAllPresensi());
              // close the dialog when state is success
              Navigator.of(context).pop();
            }
            if (state.status.isLoading) {
              // Show a loading indicator in the UI when state is loading
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Presensi Karyawan'),
          backgroundColor: COLOR.primaryColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                  });
                }
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            List<Presensi> filteredPresensi = _getFilteredPresensi();

            if (filteredPresensi.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak Ada Presensi untuk Tanggal Ini',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredPresensi.length,
              itemBuilder: (context, index) {
                final presensi = filteredPresensi[index];

                // Create a status widget for the presensi status
                Widget statusWidget = Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: presensi.Status == 'Tidak_Masuk'
                        ? Colors.red
                        : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    presensi.Status,
                    style: const TextStyle(color: Colors.white),
                  ),
                );

                if (presensi.Status == 'Tidak_Masuk') {
                  // Return a simple ListTile when presensi status is 'Tidak_Masuk'
                  return ListTile(
                    title: Text(presensi.Nama_Karyawan),
                    subtitle: Text(presensi.Status),
                    trailing: statusWidget,
                  );
                } else {
                  // Wrap the ListTile in a Slidable widget for actions
                  return Slidable(
                    key: ValueKey(presensi.Id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            context
                                .read<ChangeToTidakHadirBloc>()
                                .add(ChangeToTidakHadir(presensi.Id));
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Tidak Masuk',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(presensi.Nama_Karyawan),
                      subtitle: Text(presensi.Status),
                      trailing: statusWidget,
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
