import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show Movie;

part 'movie.g.dart';

@RegisterType()
mixin Movie on FirestoreProto<$pb.Movie>, UserOwned {
  static final triggers = trigger<Movie>(
      delete: (r) => admin.storage().bucket().file(r.proto.movie).delete());

  static void registerInternal() {
    final fn = tasteFunctions.pubsub
        .schedule('every 24 hours')
        .onRun((_, a) => generateMovies());
    registerFunction('generate_movies_pubsub', fn, fn);
  }
}

/// Create a movie for all users who have made at least 4 posts since their last movie.
Future generateMovies() => autoBatch(
      (transaction) async => (
              // Posts grouped by owner
              await DiscoverItems.get(
                  queryFn: (q) =>
                      q.orderBy('date', descending: true).limit(3000)))
          .groupBy((post) => post.userReference)
          .leftJoin(
              // Movies grouped by owner
              (await Movies.get(
                      queryFn: (q) =>
                          q.orderBy('date', descending: true).limit(3000)))
                  .groupBy((movie) => movie.userReference)
                  // Take the last movie created for that user
                  .mapValue(
                    (user, movies) => movies
                        .map((movie) => movie.proto.date.toDateTime())
                        .maxSelf,
                  ),
              // Or assume their last movie was a long time ago
              orElse: (_, a) => _longAgo)
          // Take only those users w/ at least 4 posts since last movie.
          .where((user, postsMovieDate) =>
              postsMovieDate.a
                  .where((post) =>
                      post.proto.date.toDateTime().isAfter(postsMovieDate.b))
                  .length >=
              _minPosts)
          .keys
          // Create a movies record for each eligible user.
          // This kicks off a trigger to create the actual movie.
          .futureMap(
            (createMovieUser) => Movies.createNew(transaction,
                data: {'user': createMovieUser, 'date': DateTime.now()}
                    .ensureAs(Movies.emptyInstance)
                    .documentData),
          ),
    );

final _longAgo = DateTime(1970);
const _minPosts = 4;
