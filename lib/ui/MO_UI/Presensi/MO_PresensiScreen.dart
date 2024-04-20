import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/models/Model_Presensi.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class PresensiSuccess extends StatefulWidget {
  final List<Presensi> presensi;

  const PresensiSuccess({super.key, required this.presensi});

  @override
  State<PresensiSuccess> createState() => _PresensiSuccessState();
}

class _PresensiSuccessState extends State<PresensiSuccess> {
  DateTime? selectedDate = DateTime.now(); // Default date is the current date

  List<Presensi> _getFilteredPresensi() {
    String selectedDateString = DateFormat('yyyy-MM-dd').format(selectedDate!);

    return widget.presensi.where((presensi) {
      return presensi.Tanggal == selectedDateString;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Presensi> filteredPresensi = _getFilteredPresensi();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Presensi Karyawan'),
        backgroundColor: COLOR.primaryColor,
        actions: [
          // Add a calendar icon in the app bar
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              // Show a date picker when the calendar icon is pressed
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );

              // Update the selected date if a date was picked
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
          ),
        ],
      ),
      body: filteredPresensi
              .isNotEmpty // Check if there is any presensi for the selected date
          ? ListView.builder(
              itemCount: filteredPresensi.length,
              itemBuilder: (context, index) {
                final presensi = filteredPresensi[index];

                Widget statusWidget = Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: presensi.Status == 'Tidak_Masuk'
                        ? Colors.red
                        : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    presensi.Status,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );

                // Return the list item
                return presensi.Status == 'Tidak_Masuk'
                    ? ListTile(
                        title: Text(presensi.Nama_Karyawan),
                        subtitle: Text(presensi.Status),
                        trailing: statusWidget,
                      )
                    : Slidable(
                        key: ValueKey(presensi.Id),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                // Handle delete action
                                setState(() {
                                  widget.presensi.removeAt(index);
                                });
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
              },
            )
          : Center(
              child: Text(
                'Tidak Ada Presensi untuk Tanggal Ini',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
