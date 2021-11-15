const googleApiKey = 'AIzaSyC_2NWLnZwLnqJ0rDm9SvOh32xa2Lvew3o';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude = 0,
    double longitude = 0,
  }) {
    final String locationPreviewImage =
        'https://maps.googleapis.com/maps/api/staticmap'
        '?center=$latitude,$longitude'
        '&zoom=16'
        '&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Clabel:S%7A$latitude,$longitude'
        '&key=$googleApiKey';
    print(locationPreviewImage);
    return locationPreviewImage;
  }
}
