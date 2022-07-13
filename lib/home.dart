// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController partcontroller = TextEditingController();
  TextEditingController agencycontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  DatabaseReference dref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("MM/dd/yyyy");
    final format1 = DateFormat("yyyy-MM-dd");
    String string = "Upload";
    TextEditingController fileController;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'INCOMING COMMUNICATIONS 2022',
          style: TextStyle(
              color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [_createDataTable()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Add New'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: <Widget>[
                      // TextFormField(
                      //   // controller: emailController,
                      //   decoration: InputDecoration(hintText: 'Particulars'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: partcontroller,
                          decoration: InputDecoration(hintText: 'Particulars'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: IconButton(
                              icon: Icon(Icons.upload_file),
                              onPressed: () async {
                                var picked =
                                    await FilePicker.platform.pickFiles(
                                  initialDirectory: "C:\Users\johnc\Desktop",
                                );

                                if (picked != null) {
                                  setState(() {
                                    string = picked.files.first.name.toString();
                                  });
                                }
                                ;
                              }),
                        ),
                      ),
                      Text(string),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: agencycontroller,
                          decoration:
                              InputDecoration(hintText: 'Agency/Office from'),
                        ),
                      ),
                      // TextFormField(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DateTimeField(
                            decoration: InputDecoration(
                              hintText: "Date Made",
                            ),
                            format: format,
                            controller: datecontroller,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            }),
                      ),

                      //    controller: emailController,
                      //   decoration: InputDecoration(hintText: 'Date Made'),
                      // ),
                    ]),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          dref.child("Incoming Datas").push().set({
                            "Particulars": partcontroller.text,
                            "Agency": agencycontroller.text,
                            "DateMade": datecontroller.text
                          });

                          Navigator.pop(context);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ))
                  ],
                );
              });
        },
        child: const Icon(Icons.add_outlined),
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
      ),
    );
  }
}

DataTable _createDataTable() {
  return DataTable(
    columns: _createColumns(),
    rows: _createRows(),
    dividerThickness: 5,
    dataRowHeight: 80,
    showBottomBorder: true,
    headingTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    headingRowColor:
        MaterialStateProperty.resolveWith((states) => Colors.black),
  );
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(label: Text('CONTROL NO.'), tooltip: 'CONTROL NO.'),
    DataColumn(label: Text('DATE RECEIVED')),
    DataColumn(label: Text('PARTICULARS')),
    DataColumn(label: Text('OTM CONTROL NO.')),
    DataColumn(label: Text('AGENCY//OFFICE FROM')),
    DataColumn(label: Text('DATE MADE')),
  ];
}

List<DataRow> _createRows() {
  return [
    DataRow(cells: [
      DataCell(Text('2022-02-025')),
      DataCell(Text(
        '2/2/2022',
      )),
      DataCell(
          Text('Letter of Invitation for Demonstration and Virtual Meeting')),
      DataCell(Text('')),
      DataCell(Text('The clean 02 eco-friendly Corporation')),
      DataCell(Text('1/25/2022')),
    ]),
    DataRow(cells: [
      DataCell(Text('2022-02-026')),
      DataCell(Text(
        '2/2/2022',
      )),
      DataCell(
          Text('Request for a copy of the Comprehensive Land use Plan-Clup')),
      DataCell(Text('')),
      DataCell(Text('Engineering Students')),
      DataCell(Text('1/26/2022')),
    ])
  ];
}
