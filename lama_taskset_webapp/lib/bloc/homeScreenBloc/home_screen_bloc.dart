import 'package:bloc/bloc.dart';

import 'home_screen_event.dart';
import 'home_screen_state.dart';

///[Bloc] for the [CheckScreen]
///
/// * see also
///    [HomeScreen]
///    [HomeScreenEvent]
///    [HomeScreenState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 14.07.2021
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc({HomeScreenState? initialState}) : super(initialState!);

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {}
}
