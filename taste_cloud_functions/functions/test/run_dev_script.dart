/// Run `make run-dev-script` to run this code against dev environment.
import 'utilities.dart';

void main() async {
  CloudTransformProvider.initialize();
  InstaPost instaPost;
  await autoBatch((transaction) async {
    instaPost = InstaPosts.make(
        //await '/insta_posts/Cb8V3y1kw7iKsv5KMaba'.ref.get(),
        //await '/insta_posts/LNMFBaefaqGf9t6IMYb1'.ref.get(),
        await '/insta_posts/BX281BBSntjRqli9qx70'.ref.get(),
        transaction);
    await instaPost.createReview();
  });
  print(instaPost.proto.link);
}
