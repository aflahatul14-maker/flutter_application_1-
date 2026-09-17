import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produk.dart';
import '../providers/cart_provider.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  static final List<Produk> catalogProducts = [
    Produk(
      id: 'p1',
      name: 'BerryPop Bracelet',
      price: 25000,
      imagePath: 'assets/images/berrypop bracelet.jpg',
    ),
    Produk(
      id: 'p2',
      name: 'Starlight Earrings',
      price: 35000,
      imagePath: 'assets/images/starlight earings.jpg',
    ),
    Produk(
      id: 'p3',
      name: 'BerryGlaze Ring',
      price: 15000,
      imagePath: 'assets/images/berryglaze ring.jpg',
    ),
    Produk(
      id: 'p4',
      name: 'Violet Necklaces',
      price: 40000,
      imagePath: 'assets/images/violet necklaces.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A80F0),
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.grain, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              'BlueBeads Smart-Catalog',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-product');
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cart.totalItemsCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: catalogProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (ctx, i) {
            final product = catalogProducts[i];
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEBF1FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF90CAF9), width: 1.5),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF4A80F0), width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        product.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, error, stackTrace) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.broken_image, size: 28, color: Colors.redAccent),
                              Text('Gambar Not Found', style: TextStyle(fontSize: 8, color: Colors.red)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp ${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF4A80F0)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).addItem(product);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, size: 14, color: Colors.black),
                    label: const Text('Tambah', style: TextStyle(color: Colors.black, fontSize: 12)),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}