class Item{
  String ImgPath;
  int price ;
  int fixePrice ;
  String name ;
  bool discount ;
  int discountAmount;
  String details ;
  double rating ;
  String tradeMark ;
  String type ;
  String warshaName;
  String warshaId;



  Item({
    required this.ImgPath ,
    required this.price ,
    required this.name ,
    required this.type,
    required this.details,
    required this.discount,
    required this.discountAmount,
    required this.fixePrice,
    required this.rating,
    required this.tradeMark,
    required this.warshaName,
    required this.warshaId

  });
}
