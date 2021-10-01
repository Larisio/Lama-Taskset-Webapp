import 'package:bloc/bloc.dart';

import 'create_taskset_event.dart';
import 'create_taskset_state.dart';

///[Bloc] for the [CreateTasksetScreen]
///
/// * see also
///    [CreateTasksetScreen]
///    [CreateTasksetEvent]
///    [CreateTasksetState]
///    [Bloc]
///
/// Author: L.Kammerer
/// latest Changes: 14.07.2021
class CreateTasksetBloc extends Bloc<CreateTasksetEvent, CreateTasksetState> {
  CreateTasksetBloc() : super(CreateTasksetState());

  @override
  Stream<CreateTasksetState> mapEventToState(CreateTasksetEvent event) async* {}
}
