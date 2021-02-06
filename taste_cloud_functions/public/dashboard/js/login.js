function toggleSignIn() {
  if (firebase.auth().currentUser) {
    // [START signout]
    firebase.auth().signOut();
    // [END signout]
  } else {
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    // Sign in with email and pass.
    // [START authwithemail]
    firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
      // Handle Errors here.
      var errorCode = error.code;
      var errorMessage = error.message;
      // [START_EXCLUDE]
      if (errorCode === 'auth/wrong-password') {
        alert('Wrong password.');
      } else {
        alert(errorMessage);
      }
      console.log(error);
      // [END_EXCLUDE]
    });
    // [END authwithemail]
  }
}

/**
 * initApp handles setting up UI event listeners and registering Firebase auth listeners:
 *  - firebase.auth().onAuthStateChanged: This listener is called when the user is signed in or
 *    out, and that is where we update the UI.
 */
function initApp() {
  // Listening for auth state changes.
  // [START authstatelistener]
  firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
      // User is signed in.
      var displayName = user.displayName;
      var email = user.email;
      var uid = user.uid;
      console.log(`Signed in as: ${displayName}, ${email}, ${uid}`);
      const urlParams = new URLSearchParams(window.location.search);
      const merchantId = urlParams.get('merchant_id');
      const code = urlParams.get('code');
      if (merchantId && code) {
        console.log('valid code...');
        const fn = firebase.functions().httpsCallable('create_clover_access_token');
        console.log('calling fn...');
        fn({ merchant_id: merchantId, code }).catch((reason) => {
          console.log(`cloud fn call failed... reason: ${reason}`);
        }).then((data) => {
          console.log(data);
          window.location.replace('/dashboard');
        });
      }
      // TODO(abelsm): use authCode and call cloud fn.
    } else {
      // User is signed out.
      console.log('signed out...');
    }
    // [START_EXCLUDE silent]
    // [END_EXCLUDE]
  });
}

window.onload = function () {
  initApp();
};