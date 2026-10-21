#!/bin/bash
# Tutturdum modüler feature oluşturma yardımcı betiği
# Kullanım: ./generate_feature.sh <feature_name>

FEATURE_NAME=$1

if [ -z "$FEATURE_NAME" ]; then
  echo "Hata: Modül adı belirtmelisiniz!"
  echo "Kullanım: $0 <feature_name>"
  exit 1
fi

BASE_DIR="lib/features/$FEATURE_NAME"

mkdir -p "$BASE_DIR/controllers"
mkdir -p "$BASE_DIR/models"
mkdir -p "$BASE_DIR/views"
mkdir -p "$BASE_DIR/widgets"

echo "✅ Modül başarıyla oluşturuldu: $BASE_DIR"
echo "  - $BASE_DIR/controllers/"
echo "  - $BASE_DIR/models/"
echo "  - $BASE_DIR/views/"
echo "  - $BASE_DIR/widgets/"
