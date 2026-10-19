#!/usr/bin/env bash
# Flutter Feature Generator Script
# Usage: ./generate.feature.sh <feature_name>

set -e

FEATURE_NAME="$1"

if [ -z "$FEATURE_NAME" ]; then
  echo "Hata: Lütfen bir feature adı giriniz (örn: water_tracker)"
  echo "Kullanım: $0 <feature_name>"
  exit 1
fi

BASE_DIR="lib/features/$FEATURE_NAME"

echo "Oluşturuluyor: $BASE_DIR"
mkdir -p "$BASE_DIR/controllers"
mkdir -p "$BASE_DIR/models"
mkdir -p "$BASE_DIR/views"
mkdir -p "$BASE_DIR/widgets"

echo "Klasör yapısı başarıyla oluşturuldu: $BASE_DIR"
