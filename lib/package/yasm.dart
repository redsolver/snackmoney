// YASM v0.5

import 'dart:async';

// TODO Decouple from Flutter

// TODO Tests testen

import 'package:flutter/material.dart';

class YASMStatic {
  static Map<Type, dynamic> singletons = {};
  static Map<Type, StreamController> streams = {};
}

/// Used for User Interface Classes
/* abstract class UI extends StatelessWidget { */
T $get<T>([BuildContext context]) {
  // TODO BuildContext stuff like provider
/*   print('GETSingleton');
  print(T); */
  if (T == dynamic) return null;

  var first = YASMStatic.singletons[T];
  /* singletons.firstWhere((_) => TypeMatcher<T>().check(_),
        orElse: () => null); */
  /*  print(first); */
  return first;
}

Stream<T> $stream<T>() {
/*   print('GETSingleton stream');
  print(T); */
  if (T == dynamic) return null;

  var first = YASMStatic.streams[T].stream;

  //if (TypeMatcher<Stream<T>>().check(first)) {
  if (first is Stream<T>) {
    return first;
  } else {
    return null;
  }
  /* singletons.firstWhere((_) => TypeMatcher<T>().check(_),
        orElse: () => null); */
}

/// Used for Logic Interface Classes
abstract class Logic {
  Logic() {
    /*   print('Init Logic Interface $runtimeType'); */
  }
  $set() {
    // TODO Maybe put, post or so
/*     print('notify listeners'); */

    Type type = runtimeType;

    YASMStatic.streams[type].add(this);
  }
}

class UseLogic extends StatefulWidget {
  final dynamic logic;
  final Widget Function() builder;
  final Widget child;

  UseLogic(this.logic, {this.builder, this.child});
  @override
  _UseLogicState createState() => _UseLogicState();
}

class _UseLogicState extends State<UseLogic> {
  // get liType => widget.li.runtimeType;

  List logicInterfaces;

  @override
  void initState() {
    /*    print('init'); */

    if (widget.logic is List) {
      logicInterfaces = widget.logic;
    } else {
      logicInterfaces = [widget.logic];
    }
    /*   print(logicInterfaces); */
    for (var interface in logicInterfaces) {
      YASMStatic.singletons[interface.runtimeType] = interface;
      YASMStatic.streams[interface.runtimeType] = StreamController.broadcast();
      YASMStatic.streams[interface.runtimeType].add(interface);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    for (var interface in logicInterfaces) {
      /*     print('Dispose Logic Interface ${interface.runtimeType}'); */
      YASMStatic.singletons.remove(interface.runtimeType);
      YASMStatic.streams.remove(interface.runtimeType);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*    print('build'); */
    return widget.child /* .builder() */ ?? widget.builder();
  }
}

typedef LogicCallback<T> = Widget Function(T logic);

class WatchLogic<T> extends StatelessWidget {
  //@required
  final LogicCallback<T> builder;

  WatchLogic(this.builder);

  @override
  Widget build(BuildContext context) {
    var logic = YASMStatic.singletons[T];
    var stream = YASMStatic.streams[T].stream;
    if (stream == null)
      throw YASMException('Logic $T not found in active singletons');

    return StreamBuilder(
        stream: stream,
        // TODO give data or singleton
        builder: (context, data) {
          /*  print('build'); */
          return builder(logic);
        });
  }
}

class YASMException implements Exception {
  final String message;

  YASMException(this.message);

  String toString() {
    return "YASMException: $message";
  }
}
