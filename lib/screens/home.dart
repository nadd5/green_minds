import 'package:flutter/material.dart';
import 'package:green_minds/screens/perdict_screen.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      //sky and ground
                      image: DecorationImage(
                        image: AssetImage('assets/2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // logo
          Positioned(
            top: 40,
            left: 20,
            child: Image.asset(
              'assets/1.png',
              width: 60,
              height: 60,
            ),
          ),

          //slogan
          Positioned(
            top: MediaQuery.of(context).size.height * 0.27,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Nurture Nature with\nSmart Farming",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 11, 71, 0),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //qmark
          Positioned(
            top: MediaQuery.of(context).size.height * 0.37,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/q.png',
                width: 200,
                height: 200,
              ),
            ),
          ),

          //start
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CropInputScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(129, 199, 132, 1),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
