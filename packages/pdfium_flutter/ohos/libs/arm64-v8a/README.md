# Native libs (arm64-v8a)

| File | Purpose |
|------|---------|
| `libpdfium.so` | PDFium (chromium/7520) |
| `libatfork_stub.so` | `__register_atfork` stub for OHOS musl |

Android 预编译 `libpdfium.so` 依赖 `__register_atfork@LIBC`，鸿蒙无此符号。须用
`zotero_flutter/scripts/patch_pdfium_ohos_atfork.sh` 生成 stub 并 `patchelf --add-needed`。

```bash
/path/to/zotero_flutter/scripts/patch_pdfium_ohos_atfork.sh /path/to/libpdfium.so .
```

正式鸿蒙 PDFium 自编译完成后，对产出 `.so` 同样执行上述 patch。
