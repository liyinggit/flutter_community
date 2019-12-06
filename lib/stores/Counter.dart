import 'package:mobx/mobx.dart';

part 'Counter.g.dart';

class Counter = _Counter with _$Counter;

abstract class _Counter with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }

  @action
  void set(int value) {
    this.value = value;
  }

}

///想要多个页面共享的话就在这里添加全局counter
final Counter counter = Counter();
