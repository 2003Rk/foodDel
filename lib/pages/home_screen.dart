import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/details.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/widgets/widgets_support.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool icecream = false, pizza = false, salad = false, burger = false;
  Stream<QuerySnapshot>? foodItemStream;

  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItems('Pizza');

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No items found'));
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      detail: ds["Detail"],
                      name: ds["Name"],
                      price: ds["Price"],
                      image: ds["Image"],
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.all(4),
                child: Material(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Material(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Name"],
                                      style:
                                          Appwidgets.SemiboldTextFeildStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Detail"],
                                      style: Appwidgets.LightTextFeildStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\$" + ds["Price"],
                                      style: Appwidgets.boldTextFeildStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello Rahul,", style: Appwidgets.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Delicious Food,",
                  style: Appwidgets.HeadlineTextFeildStyle()),
              Text("Discover and Get Great Food",
                  style: Appwidgets.LightTextFeildStyle()),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    foodCategoryWidget(
                        'Ice - Cream', "images/ice-cream.png", icecream,
                        () async {
                      icecream = true;
                      pizza = false;
                      salad = false;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItems("Ice-cream");
                      if (mounted) {
                        setState(() {});
                      }
                    }),
                    foodCategoryWidget('Pizza', "images/pizza.png", pizza,
                        () async {
                      icecream = false;
                      pizza = true;
                      salad = false;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItems("Pizza");
                      if (mounted) {
                        setState(() {});
                      }
                    }),
                    foodCategoryWidget('Salad', "images/salad.png", salad,
                        () async {
                      icecream = false;
                      pizza = false;
                      salad = true;
                      burger = false;
                      foodItemStream =
                          await DatabaseMethods().getFoodItems("Salad");
                      if (mounted) {
                        setState(() {});
                      }
                    }),
                    foodCategoryWidget('Burger', "images/burger.png", burger,
                        () async {
                      icecream = false;
                      pizza = false;
                      salad = false;
                      burger = true;
                      foodItemStream =
                          await DatabaseMethods().getFoodItems("Burger");
                      if (mounted) {
                        setState(() {});
                      }
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              allItemsVertically(),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodCategoryWidget(
      String foodType, String imagePath, bool isSelected, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(8),
          child: Image.asset(
            imagePath,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
