// import 'package:bloc/bloc.dart';
// import 'package:conferenceapp/common/logger.dart';

// class SimpleBlocDelegate extends BlocObserver {
//   @override
//   SimpleBlocDelegate.onEvent(Bloc bloc, Object event) {
//     super.onEvent(bloc, event);
//     logger.info('$bloc event: $event');
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     logger.info('$bloc: $transition');
//   }

//   @override
//   SimpleBlocDelegate.onError(Bloc bloc, Object error, StackTrace stacktrace) {
//     super.onError(bloc, error, stacktrace);
//     logger.errorException(error, stacktrace);
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:conferenceapp/common/logger.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Logger().info('${bloc.runtimeType} $change');
  }
}
