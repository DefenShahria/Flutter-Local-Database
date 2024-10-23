class Cart{
  final int id;
  final String title;
  final String price;
  final String description;
  final String quantity;

  const Cart({required this.id, required this.title, required this.price,required this.description, required this.quantity});

  factory Cart.fromJson(Map<String,dynamic> json) => Cart(
    id: json['id'],
    title: json['title'],
    price: json['price'],
    description: json['description'],
    quantity: json['quantity']
  );

  Map<String,dynamic> toJson() =>{
    'id' : id,
    'title' : title,
    'price' : price,
    'description' : description,
    'quantity' : quantity
  };

}