#!/bin/sh

if [[ $FLAVOR == *"dev"* ]]; then
    cp $PRODUCT_NAME/Firebase/dev/GoogleService-Info.plist $PRODUCT_NAME/GoogleService-Info.plist
    cp $PRODUCT_NAME/Firebase/dev/firebase_app_id_file.json $PRODUCT_NAME/firebase_app_id_file.json
elif [[ $FLAVOR == *"prod"* ]]; then
    cp $PRODUCT_NAME/Firebase/prod/GoogleService-Info.plist $PRODUCT_NAME/GoogleService-Info.plist
    cp $PRODUCT_NAME/Firebase/prod/firebase_app_id_file.json $PRODUCT_NAME/firebase_app_id_file.json
else
    echo "configuration didn't match to 'dev' or 'prod'"
    echo "Your FLAVOR is '$FLAVOR'"
    exit 1
fi

