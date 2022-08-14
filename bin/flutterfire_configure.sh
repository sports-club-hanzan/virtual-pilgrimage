#!/bin/bash
flutterfire configure \
    --project=virtual-pilgrimage-dev \
    --out=lib/gen/firebase_options_dev.dart \
    --ios-bundle-id=com.virtualpilgrimage.dev \
    --android-package-name=com.virtualpilgrimage.dev
flutterfire configure \
    --out=lib/gen/firebase_options_prod.dart \
    --ios-bundle-id=com.virtualpilgrimage.prod \
    --android-package-name=com.virtualpilgrimage.prod \
    --project=virtual-pilgrimage-prd
