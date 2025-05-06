class SearchService {
 final List<String> _mockProducts = [
  'T-Shirts',
  'Jeans',
  'Jackets',
  'Shoes',
  'Shirts',
  'Denim Shorts',
  'Sarees',
  'Casual Hoodies',
  'Winter Coats',
  'Polo Shirts',
];


  Future<List<String>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 500)); 

    if (query.isEmpty) {
      return []; 
    }

   
    final results = _mockProducts
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return results; 
  }
}

