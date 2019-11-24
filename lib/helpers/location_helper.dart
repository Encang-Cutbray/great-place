const GOOGLE_API_KEY = 'AIzaSyCHicCY8Oao_qeu4dIZbC5vGrx4IwOhOp4';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
        print('the longtitide $longitude');
    return 'https://maps.googleapis.com/maps/api/staticmap?' +
        'center=$latitude,$longitude' +
        '&zoom=16&size=600x300&maptype=roadmap' +
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude' +
        '&key=$GOOGLE_API_KEY';
  }
}
