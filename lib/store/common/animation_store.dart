import 'package:mobx/mobx.dart';

part 'animation_store.g.dart';

class AnimationStore = _AnimationStore with _$AnimationStore;

abstract class _AnimationStore with Store {
  @observable
  bool willStart = false;

  @observable
  int intData = 0;

  @computed
  bool get intDataMaxed => intData == _intDataUpperLimit;

  int? _intDataLowerLimit;
  int? _intDataUpperLimit;

  @action
  void start() => willStart = true;

  @action
  void stop() => willStart = false;

  @action
  void setDataLimit({int? lowerLimit, int? upperLimit}) {
    _intDataLowerLimit = lowerLimit;
    _intDataUpperLimit = upperLimit;
    setData(intData);
  }

  @action
  void setData(int data) => intData = data
      .clamp(_intDataLowerLimit ?? double.negativeInfinity, _intDataUpperLimit ?? double.infinity)
      .toInt();

  @action
  void increment() => setData(intData + 1);

  @action
  void decrement() => setData(intData - 1);

  @action
  void reset() => setData(0);
}
