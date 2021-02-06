pushd taste_cloud_functions
make deploy-$1
popd
VERSION=$(cat taste/pubspec.yaml | yq r - version)
MINOR=$(date -u +"%y-%m-%d-%H-%M-%S")
TAG=cf.$1.$VERSION.$MINOR
git tag $TAG
git push origin $TAG
