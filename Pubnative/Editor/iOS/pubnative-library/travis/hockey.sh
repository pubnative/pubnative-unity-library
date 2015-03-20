#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  echo "This is a pull request. No deployment will be done."
  exit 0
fi
if [[ "$TRAVIS_BRANCH" != "development" ]]; then
  echo "Testing other branch than development. No deployment will be done."
  exit 0
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/distribution.mobileprovision"
DEVELOPER_NAME="iPhone Distribution: HitFox App Discovery GMBH"
APP_NAME="PubnativeDemo"

echo "****************************"
echo "*     BUILDING RELEASE     *"
echo "****************************"
xctool -workspace pubnative-ios-library.xcworkspace \
       -scheme PubnativeDemo \
       -sdk iphoneos \
       -configuration Release \
       OBJROOT=$TRAVIS_BUILD_DIR \
       SYMROOT=$TRAVIS_BUILD_DIR \
       clean build

echo "****************************"
echo "*       BUILDING IPA       *"
echo "****************************"
xcrun -log -sdk iphoneos PackageApplication "$TRAVIS_BUILD_DIR/Release-iphoneos/$APP_NAME.app" -o "$TRAVIS_BUILD_DIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

echo "****************************"
echo "*    ZIPPING dSYM FILE     *"
echo "****************************"
zip -r -9 "$TRAVIS_BUILD_DIR/$APP_NAME.app.dSYM.zip" "$TRAVIS_BUILD_DIR/Release-iphoneos/$APP_NAME.app.dSYM"

echo "****************************"
echo "*   UPLOAD TO HOCKEY   *"
echo "****************************"
RELEASE_NOTES="Travis CI Build: $TRAVIS_BUILD_NUMBER"
curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
-H "X-HockeyAppToken: $HOCKEY_API_TOKEN" \
-F ipa="@$TRAVIS_BUILD_DIR/$APP_NAME.ipa" \
-F dsym="@$TRAVIS_BUILD_DIR/$APP_NAME.app.dSYM.zip" \
-F notes="$RELEASE_NOTES" \
-F notes_type="0" \
-F notify="0" \
-F status="2"


