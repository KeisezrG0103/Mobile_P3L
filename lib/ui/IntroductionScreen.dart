import 'package:flutter/material.dart';
import 'package:untitled/constant/Color.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You cannot go back from this screen',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Background Image Container
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/asset_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Container for "human" image
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1 / 2 - 100,
              child: Container(
                transform: Matrix4.translationValues(
                    -10.0, MediaQuery.of(context).size.height * 1 / 3, 0.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Human_OK.png'),
                    scale: 1.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Logo Container
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 1 / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 10),
                    topRight: Radius.elliptical(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 10),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    // Title
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Text(
                            'BEST SWEETS',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'IN',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' TOWN!',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: COLOR.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Kami Hadir Untuk Memberikan Anda \n Kelezatan Yang Hakiki',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                            //text spacing
                            strutStyle: const StrutStyle(
                              height: 1.5,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Subtitle
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: COLOR.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/FirstScreen', (route) => false);
                                },
                                child: const Text(
                                  'Mulai',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
