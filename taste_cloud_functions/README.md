# Taste Cloud Functions
All cloud functions, Firestore triggers, Storage triggers, security rules and testing for Taste backend.

## Background

This code defines [cloud functions](https://firebase.google.com/docs/functions) which run on Firebase's servers.

There are two distinct types of functions used at the moment:

1. [`onCall` endpoints](https://firebase.google.com/docs/functions/callable), which are simply `https` endpoints that can be directly called by the client or admin with simple `POST` requests. Firebase does the extra heavy-lifting of providing an authenticated user handle to the call-context, and other goodies that we need to explore further.

2. [triggers](https://firebase.google.com/docs/functions/firestore-events for various Firebase events, like Firestore document creates, or storage item create/delete.

Both types are registered in the same `main` dart function `functions/dart/index.dart` of this library, and discussed more thoroughly in the code documentation.

### Compilation to JS

Firebase Cloud functions currently only support JS (or TypeScript), both of which I feel like are not fun to work with.

Others felt similarly, and have written the [firebase_admin_interop](https://pub.dev/packages/firebase_admin_interop) and [firebase_functions_interop](https://pub.dev/packages/firebase_functions_interop) libraries, which allow you to write cloud functions in `Dart`, and compile it to `JS`. These `JS` files are what are actually deployed to the Firebase servers. Our `dart` code is just a human-readable intermediary between us and Firebase's servers.

The interop libraries are just proxies between our code and the underlying `JS` libraries written by the `Firebase` team, allowing us to have higher velocity in Dart.

### Deploying

Firebase provides an `npm` package `firebase-tools`, which gives you a `firebase` binary to deploy the functions written here to Firebase's servers.

So the flow is:
* Write some function logic for a new trigger/onCall that you want to add to the server in `index.dart`.
* Register the new function with a unique name in the `main` function of `index.dart`.
* Compile `index.dart` to `index.dart.js`
* Deploy to Firebase using `firebase` command from CLI.

All of these steps are handled semi-automatically via `Makefile` commands and described in this document below, simplifying the develop/release process.

### What is `cloud_functions` Dart package?

[`cloud_functions`](https://pub.dev/packages/cloud_functions) is an Android/iOS flutter package, that is meant to run on the actual mobile application you are writing, allowing the user of your application to easily call cloud functions from within the app. It requires the runtime to be Android/iOS, and thus is not useful *writing* cloud function definitions, rather, it's useful for *calling* cloud functions from with a mobile app.

So, a global picture is:

1. Define cloud function in this repo.
2. Deploy cloud function to prod using `firebase_functions_interop`
3. Call cloud functions from Android/iOS client using `cloud_functions`.

## Known issues
The emulator hangs and never actually starts from time to time.  Wait a few seconds, kill it if it stalls, and hunt down any lingering `java` server which is still occupying port `5001`:

```bash
ps aux | grep 5001 | grep java
```

And kill that process, otherwise you cannot start a new emulator.
## Install
### Prerequisites
* Dart
* NPM
* Python
    * See `requirements.txt`
        * pip3 install -r requirements.txt
    * Python version >= 3.7.4
        * Note that the default Mac python is `v2.7.*`. It's recommended to use
          homebrew to install python.
        * You can set the default `python` alias to point to homebrew's
          installation. [See this link for more info.](https://opensource.com/article/19/5/python-3-default-mac)
* Firebase Tools
    * npm install -g firebase-tools
* JDK

### Install for the first time
```bash
make install
```
### Cleaning up
```bash
make clean
```

## Overview

`functions/dart/index.dart` defines the backend functions.

`make gen` will compile this `dart` file into `js`, which is the only supported language by Firebase Cloud Functions at the moment.

## Testing

### Authentication issues

If you get a complaint that you need to be authenticated to run these tests, then run this locally on your machine:

```bash
gcloud auth application-default login
```

This will authenticate against your Google user via the browser. The tests run fastest this way.

An alternative is to use the service account in the directory:

```bash
GOOGLE_APPLICATION_CREDENTIALS=`pwd`/testing-service-account.json  make test
```

Which makes the tests take longer to run, unfortunately.

### General

`functions/test/functions_test.py` holds the test suite. It launches the `firebase` emulator locally (or not if it detects it's already running), and runs tests against the emulator.

`make gen-test` creates functions which are always authenticated against a user with ID `test-user-id`, as `emulator` doesn't support authentication yet.

Thus, `make gen` is for prod, `make gen-test` is for testing.

### Running individual tests

Tests take a rather long time to run, so to make development iteration faster, run individual tests:

```bash
make test PYTEST_ARGS='functions_test.py::test_empty_trophies'
```

### Emulator

**NOTE**: Emulator will reload your functions automatically without a restart when a DEV BUILD is triggered. For instance, the following sequence will work fine:

1. Run emulator in one tab
2. `make test` in other tab
3. Make change to backend code
4. `make test` in other tab

In between `3` and `4`, the `Makefile` will trigger a `js` rebuild, and `emulator` will automatically pick up those changes before running the tests in `4`.

For fast iteration on testing, you may choose to leave an emulator running, instead of starting one up and stopping after each test.

Run this in one tab:
```bash
make emulator
```

Then run this in a separate tab concurrently, as you update tests:

```bash
make test
```

## Deploy
```bash
make deploy-functions
```

## Automated testing
Dockerfile builds a test image which launches tests against an emulator. This is configured to be trigged when a user posts the comment `/gcbrun` on a pull request.