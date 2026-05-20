import 'dart:io';

/// 由嵌入应用（如 hongdou_flutter）在调用 [pdfrxInitialize] 之前设为 `true`。
///
/// [pdfrx_engine] 不依赖 Flutter，无法使用 [TargetPlatform.ohos]。
bool pdfrxHostIsOpenHarmony = false;

/// 当前运行时是否为 OpenHarmony / HarmonyOS NEXT。
bool get pdfrxRuntimeIsOpenHarmony =>
    pdfrxHostIsOpenHarmony || _isOhosOperatingSystem();

bool _isOhosOperatingSystem() {
  try {
    final os = Platform.operatingSystem;
    return os == 'ohos' || os == 'harmonyos';
  } catch (_) {
    return false;
  }
}

/// 与 Linux/Android 相同：动态加载 `libpdfium.so`、pthread 文件访问实现。
bool get pdfrxUseLinuxLikeNative =>
    Platform.isLinux ||
    Platform.isAndroid ||
    pdfrxRuntimeIsOpenHarmony;
