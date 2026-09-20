import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

/// Streaming SHA-256 of a file (hex lowercase).
Future<String> sha256FileHex(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    throw StateError('File missing for checksum: $path');
  }
  final digest = await sha256.bind(file.openRead()).single;
  return digest.toString();
}

Future<void> verifySha256OrThrow({
  required String path,
  required String expectedHex,
}) async {
  final actual = await sha256FileHex(path);
  final expected = expectedHex.trim().toLowerCase();
  if (actual != expected) {
    try {
      await File(path).delete();
    } catch (_) {}
    throw StateError(
      'Model checksum mismatch. Expected $expected, got $actual. '
      'File deleted; please download again.',
    );
  }
}

/// Constant-time-ish compare for short hex strings (defense in depth).
bool sha256Equals(String a, String b) {
  final aa = utf8.encode(a.trim().toLowerCase());
  final bb = utf8.encode(b.trim().toLowerCase());
  if (aa.length != bb.length) return false;
  var diff = 0;
  for (var i = 0; i < aa.length; i++) {
    diff |= aa[i] ^ bb[i];
  }
  return diff == 0;
}
