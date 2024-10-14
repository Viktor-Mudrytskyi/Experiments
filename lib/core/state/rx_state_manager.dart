import 'package:rxdart/rxdart.dart';

abstract class BlocEvent {}

abstract class BlocState {}

abstract class BaseBloc<Event extends BlocEvent, State extends BlocState> {
  BaseBloc(State initialState) {
    _stateController.add(initialState);
    _eventController.stream.listen(mapEventToState);
  }
  final _eventController = PublishSubject<Event>();
  final _stateController = BehaviorSubject<State>();

  Stream<State> get stateStream => _stateController.stream;

  State get currentState => _stateController.value;

  void addEvent(Event event) {
    if (!_eventController.isClosed) {
      _eventController.sink.add(event);
    }
  }

  void mapEventToState(Event event);

  void emit(State state) {
    if (!_stateController.isClosed) {
      _stateController.sink.add(state);
    }
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
