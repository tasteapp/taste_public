COM_COUNT=`git rev-list --count HEAD`
BUILD_NUM=`expr $COM_COUNT + 300000000`
VERSION=`cat taste/pubspec.yaml | yq r - version`
TAG=android.release.taste.$VERSION.$BUILD_NUM
echo $TAG
git tag $TAG
git push origin $TAG
cd taste/ios && bundle exec fastlane beta --verbose