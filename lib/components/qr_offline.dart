import 'package:flutter/material.dart';
import 'package:ieid/utils/my_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

class QrOffline extends StatefulWidget {
  const QrOffline({super.key});

  @override
  State<QrOffline> createState() => _QrOfflineState();
}

class _QrOfflineState extends State<QrOffline> {
  final storage = MyService.instance.storage;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == true) {
          final user = storage.getItem('user');
          final vCard = VCard();
          vCard.firstName = user['name'];
          print(user);
          return QrImageView(data: vCard.getFormattedString(), size: 200);
        }
        return const Center(
          child: Text(
            'No data found',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    );
  }
}
