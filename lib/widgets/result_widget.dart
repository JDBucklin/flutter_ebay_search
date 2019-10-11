import 'package:ebay_search_app/routes/item_route.dart';
import 'package:flutter/material.dart';
import '../models/result.dart';

class ResultWidget extends StatelessWidget {
  final _height = 100.0;
  final String imageUrl;
  final String title;
  final String itemID;

  ResultWidget(Result result)
      : this.imageUrl = result.imageURL,
        this.title = result.title,
        this.itemID = result.itemID;

  void _navigateToItemScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ItemRoute(itemID)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: InkWell(
        onTap: () => _navigateToItemScreen(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(this.imageUrl),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    this.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
