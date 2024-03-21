import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:open_document/my_files/init.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class OrderDetail extends StatelessWidget {
  final dynamic orderdata;
  OrderDetail({super.key, this.orderdata});

  final indianRupeesFormat = NumberFormat.currency(
    name: "INR",
    locale: 'en_IN',
    decimalDigits: 2, // change it to get decimal places
    symbol: '₹ ',
  );

  Future<Uint8List> createInvoice(orderdata) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Billing Details:'),
            pw.Text('Name: Moksh Upadhyay'),
            pw.Text('Semester: 3rd'),
            // Add more billing details as needed

            pw.SizedBox(height: 20),

            pw.Text('Items:'),

            pw.SizedBox(height: 20),

            pw.Text(
              'Total Amount: \$55', // Calculate the total amount dynamically
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }

  Future<void> savedPdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filepath = "${output.path}/$fileName.pdf";
    final file = File(filepath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filepath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Order Details", style: TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.grey.shade300,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Text(
                      orderdata['Order_id'].toString(),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Order Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Text(
                      intl.DateFormat('dd/M/yyyy hh:mm aaa').format(orderdata['Order_time'].toDate()),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Shipping Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${orderdata['Name']} ${orderdata['Email']} ',
                          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                        ),
                        Text(
                          '${orderdata['Address']} ${orderdata['City']} ${orderdata['State']}',
                          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Shipping Method',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Text(
                      orderdata['Shipping Method'].toString(),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Text(
                      orderdata['Payment Method'],
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                      ),
                    ),
                    Text(
                      indianRupeesFormat.format(orderdata['Total amount']),
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 2,
            indent: 25.0,
            endIndent: 25.0,
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.grey.shade300,
            ),
            child: Column(
              children: [
                Text(
                  "Ordered Products",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade300 : Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderdata['Orders'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(orderdata['Orders'][index]['Name']),
                              Text(
                                'Quantity: x${orderdata['Orders'][index]['Quantity']}'.toString(),
                                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                indianRupeesFormat.format(orderdata['Orders'][index]['Price']).toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              Uint8List byteList = await createInvoice(orderdata);
              savedPdfFile("Invoice", byteList);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).brightness == Brightness.dark ? Colors.orange.shade400 : Colors.blue.shade400,
              ),
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: const Text(
                'Download Invoice',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
