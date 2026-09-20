import 'dart:async';

/// Эмитит пару последних значений двух стримов (аналог combineLatest2 без rxdart).
Stream<(A, B)> combineLatest2<A, B>(Stream<A> a, Stream<B> b) {
  late StreamController<(A, B)> controller;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;
  A? latestA;
  B? latestB;
  var hasA = false;
  var hasB = false;

  void emitIfReady() {
    if (hasA && hasB && !controller.isClosed) {
      controller.add((latestA as A, latestB as B));
    }
  }

  controller = StreamController<(A, B)>(
    onListen: () {
      subA = a.listen(
        (value) {
          latestA = value;
          hasA = true;
          emitIfReady();
        },
        onError: controller.addError,
        onDone: () {
          if (!(subB?.isPaused ?? true) && !hasB) {
            controller.close();
          }
        },
      );
      subB = b.listen(
        (value) {
          latestB = value;
          hasB = true;
          emitIfReady();
        },
        onError: controller.addError,
        onDone: () {
          if (!(subA?.isPaused ?? true) && !hasA) {
            controller.close();
          }
        },
      );
    },
    onCancel: () async {
      await subA?.cancel();
      await subB?.cancel();
    },
  );

  return controller.stream;
}

/// Эмитит тройку последних значений трёх стримов.
Stream<(A, B, C)> combineLatest3<A, B, C>(
  Stream<A> a,
  Stream<B> b,
  Stream<C> c,
) {
  late StreamController<(A, B, C)> controller;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;
  StreamSubscription<C>? subC;
  A? latestA;
  B? latestB;
  C? latestC;
  var hasA = false;
  var hasB = false;
  var hasC = false;

  void emitIfReady() {
    if (hasA && hasB && hasC && !controller.isClosed) {
      controller.add((latestA as A, latestB as B, latestC as C));
    }
  }

  controller = StreamController<(A, B, C)>(
    onListen: () {
      subA = a.listen(
        (value) {
          latestA = value;
          hasA = true;
          emitIfReady();
        },
        onError: controller.addError,
      );
      subB = b.listen(
        (value) {
          latestB = value;
          hasB = true;
          emitIfReady();
        },
        onError: controller.addError,
      );
      subC = c.listen(
        (value) {
          latestC = value;
          hasC = true;
          emitIfReady();
        },
        onError: controller.addError,
      );
    },
    onCancel: () async {
      await subA?.cancel();
      await subB?.cancel();
      await subC?.cancel();
    },
  );

  return controller.stream;
}
