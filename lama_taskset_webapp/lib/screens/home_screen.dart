import 'package:flutter/material.dart';
import 'package:lama_taskset_webapp/utils/util_colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _homeView());
  }

  Widget _homeView() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: UtilsColors.greyAccent,
        ),
        child: Container(
          width: 200,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Icon(
                Icons.add_rounded,
                size: 60,
                color: UtilsColors.greyPrimary,
              ),
              SizedBox(height: 75),
              Text(
                "Aufgabenpaket erstellen",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: UtilsColors.greyPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        onPressed: () => {},
      ),
    );
  }
}
