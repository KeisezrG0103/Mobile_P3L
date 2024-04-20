import 'package:flutter/material.dart';
import 'package:untitled/constant/Color.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  image: AssetImage('assets/human_firstPage.png'),
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
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'EXPLORE',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' US!',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: COLOR.primaryColor,
                          ),
                        ),
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
                                Navigator.pushNamed(context, '/login');
                                Navigator.canPop(context);
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: BorderSide(
                                    color: COLOR.primaryColor, width: 2),
                                //rounded border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/', (Route<dynamic> route) => false);
                              },
                              child: Text(
                                'CONTINUE AS GUEST',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: COLOR.primaryColor,
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
    );
  }
}
