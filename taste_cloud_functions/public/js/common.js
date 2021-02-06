const refUrl = document.location.href.includes('dev.trytaste.app') ? "dref" : "ref";
const functions = firebase.functions();
const isTestingMode = document.location.href.startsWith('http://localhost');
const isDevMode = document.location.href.includes('dev.trytaste.app') || isTestingMode;

if (isTestingMode) {
  functions.useFunctionsEmulator('http://localhost:5001');
}