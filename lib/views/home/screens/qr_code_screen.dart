import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:socialscan/utils/button.dart';
import 'package:socialscan/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/images.dart';
import '../widgets/horizontal_dot_tile.dart';

class QrCodeScreen extends StatefulWidget {
  final List<String>? qrData;
  const QrCodeScreen({super.key, this.qrData});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  String generateMultiLinkURI(List<String> qrData) {
    return qrData.map((link) => Uri.encodeComponent(link)).join(';');
  }

  void openSelectedLink(String encodedLinks, String chosenLink) {
    final decodedLinks = encodedLinks.split(';');
    final index = decodedLinks.indexOf(chosenLink);
    if (index >= 0 && index < decodedLinks.length) {
      _launchURL(decodedLinks[index]);
    } else {
      // Handle scenario where chosen link is not found (optional)
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Url link ====> ${widget.qrData}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
        title: Text(
          'QR Code',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            const HorizontalDotTile(),
            const SizedBox(
              height: 30,
            ),
            if (widget.qrData != null)
              SizedBox(
                height: 300,
                width: 300,
                child: PrettyQrView.data(
                  data: generateMultiLinkURI(widget.qrData!),
                  decoration: PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                      padding: const EdgeInsets.all(10),
                      image: AssetImage(socialIcon),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 27,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Scan QR with recipient device to connect.',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ProjectColors.mainPurple,
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 4.5,
            // ),
            const Spacer(),
            ButtonTile(
              text: 'Share',
              textColor: Colors.black,
              boxRadius: 35,
              icon: SvgPicture.asset(shareIcon),
              color: const Color(0xFFECECEC),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonTile(
              width: double.infinity,
              text: "Download",
              boxRadius: 35,
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
              onTap: () async {
                final qrCode = QrCode.fromData(
                  data: generateMultiLinkURI(widget.qrData!),
                  errorCorrectLevel: QrErrorCorrectLevel.H,
                );

                final qrImage = QrImage(qrCode);
                final qrImageBytes = await qrImage.toImageAsBytes(
                  size: 512,
                  format: ImageByteFormat.png,
                  decoration: PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                      padding: const EdgeInsets.all(10),
                      image: AssetImage(socialIcon),
                    ),
                  ),
                );

                // Get the temporary directory of the device.
                final directory = await getTemporaryDirectory();

                // Create a file in the temporary directory.
                final File file = File('${directory.path}/qr_code.png');

                // Compress the image and write it to the file.
                final compressedImage =
                    await FlutterImageCompress.compressWithList(
                  qrImageBytes!.buffer.asUint8List(),
                  minWidth: 512,
                  minHeight: 512,
                  quality: 88,
                );
                await file.writeAsBytes(compressedImage, flush: true);

                // The image file is now saved in the device's temporary directory.
                print('Image saved at ${file.path}');
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
          ],
        ),
      ),
    );
  }
}
