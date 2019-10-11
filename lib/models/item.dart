import 'result.dart';

class Item {
  final String title;
  String imageUrl;
  final int bidCount;
  final List<dynamic> buyingOptions;
  final String condition;
  final String price;
  final String seller;

  Item(this.title,
      this.imageUrl,
      this.bidCount,
      this.buyingOptions,
      this.condition,
      this.price,
      this.seller) :
      assert(title != null);

  Item.fromJson(Map<String, dynamic> json) :
        title = json['title'],
        imageUrl = json['image'] != null ? json['image']['imageUrl'] : Result.defaultImageUrl,
        buyingOptions = json['buyingOptions'],
        bidCount = json['bidCount'],
        condition = json['condition'],
        price = json['price']['value'].toString() + " " + json['price']['currency'],
        seller = json['seller']['username'];
}