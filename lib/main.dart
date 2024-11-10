import 'package:flutter/material.dart';
import 'package:food_app_demo/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'carousel_card.dart';
import 'cart_page_items.dart';
import 'food_vertical_list.dart';

void main() {
  runApp( const ProviderScope(
      overrides: [
      ],
      child: MyApp(

      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: (){
          showModalBottomSheet(context: context,
              isScrollControlled:true,
              builder: (BuildContext c){
                return const CartPage();
              });
        },
        label: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text(
                    '24 min',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Text(
                '\$${ref.watch(foodDeliveryViewModel).pTotalAmount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 100,
      //   child: Text('TTTTTT'),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20), // Adjust for oval shape
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '100a Ealing Rd',
                style: TextStyle(color: Colors.white,fontSize: 12), // Use white for better contrast
              ),
              SizedBox(width: 8),
              Icon(Icons.access_time, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                '24 mins',
                style: TextStyle(color: Colors.white,fontSize: 12),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hits of the week section
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hits of the week',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            CarouselExample(),

            SizedBox(height: 20),

            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryButton(title: 'Salads'),
                    CategoryButton(title: 'Pizza'),
                    CategoryButton(title: 'Beverages'),
                    CategoryButton(title: 'Snacks'),
                  ],
                ),
              ),
            ),
            VerticalListFoodItems(),

            SizedBox(height: 20),

            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String title;

  const CategoryButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String kcal;

  const FoodItem({super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.kcal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Food Image
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),

        // Food Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              kcal,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}