class Product {
  final String description;
  final String image_path;
  final int price;
  Product({required this.description,required this.image_path,required this.price});

  Product.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        image_path = json['image_path'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'description': description,
        'image_path': image_path,
        'price':price
      };
}
