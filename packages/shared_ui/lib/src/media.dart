/// Cloudinary account the API's `publicId`s live in (§16).
/// Set with `--dart-define=CLOUDINARY_CLOUD_NAME=...`; empty in local dev without Cloudinary.
const cloudinaryCloudName = String.fromEnvironment('CLOUDINARY_CLOUD_NAME');

/// Delivery URL for a photo: 4:3 fill, auto format/quality, sized for the screen.
/// Returns null when no cloud is configured so callers can show a placeholder.
String? photoUrl(String publicId, {int width = 800, String ratio = '4:3', String cloudName = cloudinaryCloudName}) {
  if (cloudName.isEmpty) return null;
  return 'https://res.cloudinary.com/$cloudName/image/upload/c_fill,ar_$ratio,w_$width,q_auto,f_auto/$publicId';
}
