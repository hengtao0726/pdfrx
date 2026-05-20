# OpenHarmony: bundle prebuilt libpdfium.so from libs/${OHOS_ARCH}/.
# Build PDFium for OHOS (chromium/7520) and copy:
#   cp out/.../libpdfium.so ohos/libs/arm64-v8a/
cmake_minimum_required(VERSION 3.10)
project(pdfium_flutter LANGUAGES CXX)

if(NOT DEFINED OHOS_ARCH)
  set(OHOS_ARCH "arm64-v8a")
endif()

set(PDFIUM_PREBUILT "${CMAKE_CURRENT_SOURCE_DIR}/libs/${OHOS_ARCH}/libpdfium.so")
set(ATFORK_PREBUILT "${CMAKE_CURRENT_SOURCE_DIR}/libs/${OHOS_ARCH}/libatfork_stub.so")
set(LIBCXX_SHARED "${CMAKE_CURRENT_SOURCE_DIR}/libs/${OHOS_ARCH}/libc++_shared.so")

if(EXISTS "${PDFIUM_PREBUILT}")
  set(_pdfium_ohos_libs "${PDFIUM_PREBUILT}")
  if(EXISTS "${ATFORK_PREBUILT}")
    list(APPEND _pdfium_ohos_libs "${ATFORK_PREBUILT}")
  else()
    message(WARNING
      "pdfium_flutter OHOS: missing ${ATFORK_PREBUILT}. "
      "Run zotero_flutter/scripts/patch_pdfium_ohos_atfork.sh on libpdfium.so.")
  endif()
  if(EXISTS "${LIBCXX_SHARED}")
    list(APPEND _pdfium_ohos_libs "${LIBCXX_SHARED}")
  endif()
  set(pdfium_flutter_bundled_libraries "${_pdfium_ohos_libs}" PARENT_SCOPE)
  message(STATUS "pdfium_flutter OHOS: bundling ${_pdfium_ohos_libs}")
else()
  message(WARNING
    "pdfium_flutter OHOS: missing ${PDFIUM_PREBUILT}. "
    "Build pdfium for HarmonyOS and copy libpdfium.so before flutter build hap.")
  set(pdfium_flutter_bundled_libraries "" PARENT_SCOPE)
endif()
