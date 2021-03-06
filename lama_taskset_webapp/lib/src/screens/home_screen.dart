import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lama_taskset_webapp/src/utils/util_colors.dart';

import '../bloc/homeScreenBloc/home_screen_bloc.dart';
import '../bloc/homeScreenBloc/home_screen_event.dart';
import '../bloc/homeScreenBloc/home_screen_state.dart';

/// * see also
///    [HomeScreenBloc]
///    [HomeScreenEvent]
///    [HomeScreenState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 01.10.2021
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
      appBar: AppBar(backgroundColor: UtilsColors.bluePrimary),
      body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        builder: (context, state) {
          return _homeView(context);
        },
      ),
    );
  }

  Widget _homeView(BuildContext context) {
    return Center(
        child: _homeButtons(
            Icon(
              Icons.add_rounded,
              size: 60,
              color: UtilsColors.greyPrimary,
            ),
            "Aufgabenpaket erstellen",
            () => {
                  context
                      .read<HomeScreenBloc>()
                      .add(HomeScreenCreateTasksetEvent(context))
                }));
  }

  Widget _homeButtons(
    Icon icon,
    String text,
    VoidCallback function,
  ) {
    return ElevatedButton(
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
            icon,
            SizedBox(height: 75),
            Text(
              text,
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
      onPressed: function,
    );
  }
}
