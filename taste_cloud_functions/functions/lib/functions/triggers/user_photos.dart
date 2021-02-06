import 'package:taste_cloud_functions/taste_functions.dart';

/// Creates a Firestore document upon creation of a photo in Firebase Storage.
/// Validates that the photo is being uploaded into a bucket owned by the user,
/// and that the photo is an image-type.
final createUserPhoto = functions.storage.object().onFinalize(
      (object, context) => autoBatch(
        (t) => object.contentType.contains('image/')
            // Avoid creating photos for non-photo data.
            ? Photo.createFromStoragePath(t, object.name)
            : null,
      ),
    );

void register() {
  registerFunction(
      'trigger_storage_create_photos', createUserPhoto, createUserPhoto);
}
