#!/usr/bin/env bash
# Локальная сборка APK. Нужны JDK 17+ и Android SDK (ANDROID_HOME).
# Проще всего: установить Android Studio — SDK ставится вместе с ней.
set -e
cd "$(dirname "$0")"

if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
  for d in "$HOME/Android/Sdk" "$HOME/Library/Android/sdk"; do
    [ -d "$d" ] && export ANDROID_HOME="$d" && break
  done
fi
if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
  echo "Не найден Android SDK. Установите Android Studio или задайте ANDROID_HOME." >&2
  exit 1
fi

chmod +x gradlew
./gradlew assembleRelease
cp app/build/outputs/apk/release/app-release.apk Stronghold.apk
echo "Готово: $(pwd)/Stronghold.apk"
