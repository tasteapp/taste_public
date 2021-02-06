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
analytics.logEvent("w_blm_load");
(async () => {
  const posts = await firestore
    .collection('discover_items')
    .where('black_charity', 'in', ['eji', 'aclu', 'splc'])
    .get();
  $('#amount').text(`$${posts.docs.length * 10}`);
  // Sort by time.
  const snapshots = [];
  posts.docs.forEach(d => snapshots.push(d.data()));
  snapshots.sort((a, b) => b.date.seconds - a.date.seconds);
  for (let i = 0; i < snapshots.length; i++) {
    const data = snapshots[i];
    const postHtml = `
    <div class="post-holder">
    <img src="images/${data.black_charity}_post_logo.jpg" alt="" class="image-9">
    <img src="${photoUrl(data.fire_photos[0].firebase_storage)}" width="260" 
        sizes="(max-width: 479px) 61vw, (max-width: 767px) 222px, (max-width: 991px) 159.328125px, 222px" alt=""
        class="image-7">
      <div class="post-dish truncate" title="${data.dish}">${data.dish}</div>
      <div class="post-resto truncate" title="${data.restaurant.name}">From <span class="text-span-2">${data.restaurant.name}</span></div>
      <div class="post-city truncate">${data.restaurant.address.city + ', ' + data.restaurant.address.state}</div>
      <div class="div-block"><img src="${photoUrl(data.user.photo)}" sizes="48px" alt="" class="image-8">
        <div class="text-block-3">${data.user.name}</div>
      </div>
    </div>
    `;
    const column = `#column_${i % 3}`;
    $(column).html($(column).html() + postHtml);
  }
})();
