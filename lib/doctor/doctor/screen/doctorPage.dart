import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../model/doctor.dart';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  final String url;

  const DoctorPage({Key? key, required this.doctor, required this.url})
      : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Details"),
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 80,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 190,
                  child: Text(
                    widget.doctor.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to our clinic!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We're here to provide top-notch healthcare to everyone who needs it. Thanks for trusting us with your health.",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 8),
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded = !isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              'More Information',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        body: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "We're dedicated to giving you the best care, whether it's a regular check-up or dealing with a specific issue. Your comfort and confidence during treatment are our priorities.",
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        isExpanded: _isExpanded,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ActionButton(
                        icon: Icons.mail,
                        onPressed: () => _makeMailTo('garroudjimohamedse@gmail.com'),
                        label: 'Email',
                      ),
                      ActionButton(
                        icon: Icons.call,
                        onPressed: () => _makePhoneCall(widget.doctor.phoneNumber),
                        label: 'Call',
                      ),
                      ActionButton(
                        icon: Icons.sms,
                        onPressed: () => _makeSms(widget.doctor.phoneNumber),
                        label: 'SMS',
                      ),
                      ActionButton(
                        icon: Icons.map,
                        onPressed: () => _openGoogleMapsWithAddress(widget.doctor.address),
                        label: 'Map',
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makeMailTo(String mailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    await launchUrl(launchUri);
  }

  _openGoogleMapsWithAddress(String address) async {
    MapsLauncher.launchQuery(address);
  }

  Future<void> _makeSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String label;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(16),
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          child: Icon(icon),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}