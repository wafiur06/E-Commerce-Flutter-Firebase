part of 'counter_bloc.dart';

abstract class CounterState{
  int count;
  CounterState(this.count);
}

class CounterInitial extends CounterState{
  CounterInitial(super.count);
}

class NumberIncrement extends CounterState{
  NumberIncrement(super.count);
}
class NumberDecrement extends CounterState{
  NumberDecrement(super.count);
}