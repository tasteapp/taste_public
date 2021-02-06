# Getting Apple certificates

## Get the GCP service account keys from Jack

They are only downloadable once and shouldn't be checked into source control. They can always be regenerated, but I believe it disables the old keys.

Each flutter `ios` folder needs the service account keys at `ios/gc_keys.json`.

## Install fastlane

`brew cask install fastlane`

## Go to an `ios` flutter folder and setup fastlane for that folder

`bundle install`

## Run the command to install the certificate and profiles to your machine.

`bundle exec fastlane match development`
`bundle exec fastlane match appstore`