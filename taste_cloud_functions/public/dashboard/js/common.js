function merchantLogout() {
  firebase.auth().signOut()
    .catch((error) => {
      window.location.replace('/dashboard/login');
    })
    .then(() => {
      window.location.replace('/dashboard/login');
    });
}