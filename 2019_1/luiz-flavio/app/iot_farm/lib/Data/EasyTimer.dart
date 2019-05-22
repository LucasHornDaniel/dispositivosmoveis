import 'dart:async';

class EasyTimer {

  static const oneSecond = const Duration(seconds: 1);
  Timer _timer;
  int counter;

  WaitTime(int time){
    counter = time;
    _timer = new Timer.periodic(
      oneSecond,
        (Timer timer){
          if (counter <= 0) {
            _timer.cancel();
          } else {
            counter--;
          }
        }
    );
  }

}