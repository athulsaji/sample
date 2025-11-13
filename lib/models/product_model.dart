class Product {
  final String image;
  final String title;
  final double price;
  Product ({required this.image, required this.title,required this.price});
   factory Product.fromJson(Map<String,dynamic> json){
    return Product(image: json['image'], title:json['title'], price: json['price']);
   }
}