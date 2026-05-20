import 'package:pdfrx_engine/pdfrx_engine.dart';
import 'package:synchronized/synchronized.dart';

final openHarmonyPdfPageRenderLock = Lock();

/// Runs [fn] exclusively on OpenHarmony to avoid PDFium JPEG/render SIGSEGV.
Future<T> runOpenHarmonyPdfRenderSerialized<T>(Future<T> Function() fn) async {
  if (!pdfrxRuntimeIsOpenHarmony) return fn();
  return openHarmonyPdfPageRenderLock.synchronized(fn);
}
