class Item {
  final String name;
  final String description;
  final String iconUrl;

  Item({required this.name, required this.description, required this.iconUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['display_data']['name'],
      description: json['display_data']['description'],
      iconUrl: json['display_data']['icon_url'],
    );
  }
}

class Category {
  final String title;
  final List<Item> items;

  Category({required this.title, required this.items});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      title: json['template_properties']['header']['title'],
      items: (json['template_properties']['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}
