import 'package:flutter/material.dart';

void main() {
  runApp(const GoatMarketApp());
}

class GoatMarketApp extends StatelessWidget {
  const GoatMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goat Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // High contrast colors
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF000000), // Pure black for primary text/buttons
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF005500), // Dark green for valid actions
          onSecondary: Color(0xFFFFFFFF),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF000000),
          error: Color(0xFFB00020),
          onError: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Light gray background
        // Large typography for readability
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 20, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Large tap areas for buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(88, 56), // Minimum 56dp height for tap target
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            backgroundColor: const Color(0xFF005500), // Dark green background
            foregroundColor: Colors.white, // White text
            side: const BorderSide(color: Colors.black, width: 3), // High contrast border
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
             style: FilledButton.styleFrom(
            minimumSize: const Size(88, 64), // Even larger primary actions
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            backgroundColor: Colors.black, // Pure black background
            foregroundColor: Colors.white, // White text
            side: const BorderSide(color: Color(0xFF005500), width: 3), // Dark green border
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
             style: IconButton.styleFrom(
            minimumSize: const Size(56, 56), // Minimum 56dp tap target
            iconSize: 32,
          ),
        ),
        useMaterial3: true,
      ),
      home: const ItemListPage(),
    );
  }
}

class GoatItem {
  final String id;
  final String name;
  final String breed;
  final String description;
  final double price;
  final String imageUrl;

  GoatItem({
    required this.id,
    required this.name,
    required this.breed,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// Dummy data
final List<GoatItem> dummyItems = [
  GoatItem(
    id: '1',
    name: 'Billy',
    breed: 'Alpine',
    description: 'A sturdy alpine goat, excellent milker and very friendly.',
    price: 350.00,
    imageUrl: 'https://images.unsplash.com/photo-1524024973431-2ad916746881?auto=format&fit=crop&q=80&w=200',
  ),
  GoatItem(
    id: '2',
    name: 'Daisy',
    breed: 'Nubian',
    description: 'Beautiful long-eared Nubian. Great for milk and showing.',
    price: 450.00,
    imageUrl: 'https://images.unsplash.com/photo-1548689849-0fa411bc29e3?auto=format&fit=crop&q=80&w=200',
  ),
  GoatItem(
    id: '3',
    name: 'Snowball',
    breed: 'Saanen',
    description: 'Pure white Saanen goat. Extremely docile and productive.',
    price: 400.00,
    imageUrl: 'https://images.unsplash.com/photo-1502472288078-d51ef05ffb89?auto=format&fit=crop&q=80&w=200',
  ),
  GoatItem(
    id: '4',
    name: 'Shadow',
    breed: 'Pygmy',
    description: 'A cute little black pygmy goat. Great pet for kids.',
    price: 250.00,
    imageUrl: 'https://images.unsplash.com/photo-1500350410497-6a4574bed149?auto=format&fit=crop&q=80&w=200',
  ),
  GoatItem(
    id: '5',
    name: 'Rusty',
    breed: 'Boer',
    description: 'Strong Boer goat. Ideal for breeding and meat production.',
    price: 500.00,
    imageUrl: 'https://images.unsplash.com/photo-1523315843452-fdd67329d6be?auto=format&fit=crop&q=80&w=200',
  )
];

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final List<GoatItem> _cartItems = [];

  void _addToCart(GoatItem item) {
    setState(() {
      _cartItems.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart'),
        duration: const Duration(seconds: 1),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _cartItems.removeLast();
            });
          },
        ),
      ),
    );
  }

  void _navigateToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutPage(cartItems: _cartItems),
      ),
    ).then((_) {
      // Re-render when returning in case cart is modified later
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/icon/app_icon.png'),
                ),
              ),
              onPressed: () {
                // Future: Open drawer menu
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menu coming soon!')),
                );
              },
            );
          }
        ),
        title: const Text('Goat Market', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _navigateToCheckout,
              ),
              if (_cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyItems.length,
        itemBuilder: (context, index) {
          final item = dummyItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 60),
                ),
              ),
              title: Text(item.name, 
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.breed, 
                      style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 18, color: Colors.black87)),
                  const SizedBox(height: 8),
                  Text(item.description, 
                      style: const TextStyle(fontSize: 18, color: Colors.black)),
                  const SizedBox(height: 12),
                  Text('\$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Color(0xFF005500), // Dark green
                          fontWeight: FontWeight.w900,
                          fontSize: 22)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () => _addToCart(item),
                child: const Text('Add', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _cartItems.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _navigateToCheckout,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.shopping_cart_checkout, size: 32),
              label: Text('Checkout (${_cartItems.length})', 
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
          : null,
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final List<GoatItem> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  double get _totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // The back button is automatically provided by AppBar when pushed
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image, size: 40),
                            ),
                          ),
                          title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                          subtitle: Text(item.breed, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                          trailing: Text(
                            '\$${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF005500)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${_totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Checkout not implemented yet')),
                              );
                            },
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                            ),
                            child: const Text('Proceed to Payment', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
