import 'package:bloc/bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBlocBloc extends Bloc<CounterEvent, CounterState> {
  CounterBlocBloc() : super(CounterInitial(0)) {
    int count = 0;

    on<CounterEvent>((event, emit) {

      if(event is Increment){
        //function
        count++;
        emit(NumberIncrement(count));
      }
      if(event is Decrement){
        count--;
        emit(NumberDecrement(count));

      }
    });
  }
}