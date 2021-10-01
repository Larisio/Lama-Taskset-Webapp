import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';

import '../bloc/homeScreenBloc/home_screen_bloc.dart';
import '../bloc/homeScreenBloc/home_screen_event.dart';
import '../bloc/homeScreenBloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return _homeView(context);
        },
      ),
    );
  }

  Widget _homeView(BuildContext context) {
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
        onPressed: () => {
          context
              .read<HomeScreenBloc>()
              .add(HomeScreenCreateTasksetEvent(context))
        },
      ),
    );
  }
}
