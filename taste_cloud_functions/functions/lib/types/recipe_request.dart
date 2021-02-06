import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb show RecipeRequest;

part 'recipe_request.g.dart';

@RegisterType()
mixin RecipeRequest
    on
        FirestoreProto<$pb.RecipeRequest>,
        UserOwned,
        ParentHolder,
        UniqueUserIndexed {
  static final triggers = trigger<RecipeRequest>(
      delete: (r) => r.ensureIndexDeleted,
      create: (r) => [
            r.ensureIndexCreated,
            () async {
              final post =
                  await HomeMeals.fromPath(r.parent.path, r.transaction);
              final requester = await r.user;
              final owner = await post.user;
              return owner.sendNotification(
                documentLink: r.parent,
                title: 'New Recipe Request!',
                body:
                    '${requester.usernameOrName} requested the recipe for ${post.dish}!',
                notificationType: NotificationType.recipe_request,
              );
            }(),
          ]);
}
