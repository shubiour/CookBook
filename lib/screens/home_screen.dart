import 'package:flutter/material.dart';
import '../screens/categories_screen.dart';
import './category_meals_screen.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';
import '../dummy_data.dart';
import '../screens/category_meals_screen.dart';
import '../widgets/categories_item.dart';
import './meal_detail_screen.dart';
import '../models/meal.dart';


class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];
  

  void getPostsData() {
    List<dynamic> responseList = FOOD_DATA;
    List<Widget> listItems = [];
    //final Size size1 = MediaQuery.of(context).size;
    responseList.forEach((post) {
      listItems.add(
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments:  post["id"]);
          },
          child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Image.network(
                          post["image"],
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Container(
                          width: double.infinity,
                          color: Colors.black54,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(post["name"],
                                  style: TextStyle(
                                      fontSize: 23, color: Colors.white),
                                  softWrap: true,
                                  overflow: TextOverflow.fade),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        post["duration"],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.work,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        post["complexity"],
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
    setState(() {
      itemsData = listItems;
    });
  }

  void gotoCategoryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CategoriesScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.25;
    return SafeArea(
      //child: Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   leading: Icon(
        //     Icons.menu,
        //     color: Colors.black,
        //   ),
        //   // actions: <Widget>[
        //   //   IconButton(
        //   //     icon: Icon(Icons.search, color: Colors.black),
        //   //     onPressed: () {},
        //   //   ),
        //   //   IconButton(
        //   //     icon: Icon(Icons.person, color: Colors.black),
        //   //     onPressed: () {},
        //   //   )
        //   // ],
        // ),
        // body: 
         child: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: <Widget>[
              //     Text(
              //       "Categories",
              //       style: TextStyle(
              //           color: Colors.grey,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20),
              //     ),
              //     GestureDetector(
              //       onTap: () => gotoCategoryScreen(),
              //       child: Text(
              //         "Show All",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
     // ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  List<Meal> availableMeals = DUMMY_MEALS;
  
  void selectCategory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CategoryMealsScreen(availableMeals);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 70;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Container(
            height: categoryHeight - 50,
            width: MediaQuery.of(context).size.width,
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 1 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: DUMMY_CATEGORIES
                  .map(
                    (catData) => CategoriesItem(
                      catData.title,
                      catData.color,
                      catData.id,
                    ),
                  )
                  .toList(),
            ),
            // child: ListView.builder( /// I tried this but had a issue to pass the data to another page
            //   scrollDirection: Axis.horizontal,
            //   itemCount: DUMMY_CATEGORIES.length,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Column(
            //         children: [
            //           Container(
            //             width: 155,
            //             height: categoryHeight - 50,
            //             decoration: BoxDecoration(
            //               color: DUMMY_CATEGORIES[index].color,
            //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //             ),
            //             //color: DUMMY_CATEGORIES[index].color,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //                     margin: EdgeInsets.only(top: 15, left: 10),
            //                     child: Text(
            //                       '${DUMMY_CATEGORIES[index].title}',
            //                       style: TextStyle(
            //                           fontSize: 25,
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold),
            //                     )),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
