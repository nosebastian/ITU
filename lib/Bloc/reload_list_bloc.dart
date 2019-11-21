import 'dart:async';

class ReloadBloc{
  final _stateController = StreamController<int>.broadcast();

  StreamSink<int> get to => _stateController.sink;
  Stream<int> get publicRebuild => _stateController.stream;

  final _eventController = StreamController<int>();

  ReloadBloc(){
    _eventController.stream.listen(_eventToState);

  }

  void _eventToState(int reload){
    to.add(reload);
  }

  void _dispose(){
    _eventController.close();
    _stateController.close();
  }
}
final controller = ReloadBloc();