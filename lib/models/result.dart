class Result {
  String imageURL;
  String title;
  String itemID;
  static final String defaultImageUrl =
      'https://secureir.ebaystatic.com/pictures/aw/pics/stockimage1.jpg';

  Result({this.imageURL, this.title, this.itemID});

  factory Result.fromJson(Map<String, dynamic> json) {
    // TODO: The following line gets the real gallery image from the JSON:
    // imageURL: json['galleryInfoContainer'] == null ? defaultImageUrl : json['galleryInfoContainer'][0]['galleryURL'][2]['__value__'],
    // however, this is failing for all sandbox images from ebay's website:
    // Handshake error in client (OS Error:
    // CERTIFICATE_VERIFY_FAILED: Hostname mismatch(handshake.cc:352))
    // Instead of allowing all certificates, I'm going to use a default image

    return Result(
        imageURL: defaultImageUrl,
        title: json['title'][0].toString(),
        itemID: json['itemId'][0].toString()
    );
  }
}