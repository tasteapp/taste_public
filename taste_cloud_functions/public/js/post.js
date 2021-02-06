const firestore = firebase.firestore();
const analytics = firebase.analytics();
if (window.location.hostname === "localhost") {
  console.log("localhost detected!");
  firestore.settings({
    host: "localhost:8080",
    ssl: false,
  });
}
const project = firebase.app().options.projectId;
function photoUrl(path, thumb) {
  thumb = thumb || false;
  const size = thumb ? 200 : 600;
  if (path.startsWith("http")) {
    return path;
  }
  const start = path.substring(0, path.lastIndexOf("."));
  const end = path.substring(path.lastIndexOf("."));
  const base = start.substring(0, start.lastIndexOf("/") + 1);
  const filename = start.substring(start.lastIndexOf("/") + 1);
  return `https://storage.googleapis.com/${project}.appspot.com/${base}thumbnails/${filename}_${size}x${size}${end}`;
}
const post = document.querySelector("#post");
const id = new URLSearchParams(window.location.search).get("id");
analytics.logEvent("w_web_post", { post_id: id });
(async () => {
  const snapshot = id.startsWith("discover")
    ? await firestore.doc(id).get()
    : id.startsWith("reviews") || id.startsWith("home_meals")
    ? (
        await firestore
          .collection("discover_items")
          .where("reference", "==", firestore.doc(id))
          .limit(1)
          .get()
      ).docChanges()[0].doc
    : _error();
  const data = snapshot.data();
  const div = document.getElementsByTagName("template")[0].content;
  div.querySelector("#dish").textContent = data.dish;
  if (data.restaurant) {
    div.querySelector("#prefix").textContent = "from ";
    div.querySelector("#restaurant-name").textContent = data.restaurant.name;
  }
  div
    .querySelector("#avatar img")
    .setAttribute("src", photoUrl(data.user.photo, true));
  div.querySelector("#poster #name").textContent = data.user.name;
  div
    .querySelector("#photo img")
    .setAttribute("src", photoUrl(data.fire_photos[0].firebase_storage));
  div.querySelector("#date").textContent = moment(data.date.toDate()).fromNow();
  post.textContent = "";
  post.appendChild(div);
})();
function _error() {
  throw new Exception("Could not load!");
}
