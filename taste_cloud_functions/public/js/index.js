const analytics = firebase.analytics();
// use alphanumeric + '_' only.
// https://firebase.google.com/docs/reference/cpp/group/event-names
Object.entries({
  "smartbanner.view": "w_smartbanner_view",
  "smartbanner.clickout": "w_smartbanner_clickout",
  "smartbanner.exit": "w_smartbanner_exit",
}).forEach(([event, axTag]) =>
  document.addEventListener(event, () =>
    analytics.logEvent(axTag)));
