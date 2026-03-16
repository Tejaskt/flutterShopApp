import 'package:flutter/material.dart';
import 'package:shopapp/global_variables.dart';
import 'package:shopapp/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final List<String> filters = const ['All','Adidas','Nike','Bata '];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(
        children: [

          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Shoes\nCollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: border,
                          enabledBorder: border,
                          focusedBorder: border
                      )
                  )
              )
            ],
          ),

          SizedBox(
            height: 90,
            child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        side: BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        backgroundColor: selectedFilter == filter ? Theme.of(context).primaryColor : Color.fromRGBO(245, 247, 249, 1),
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                        label: Text(filter),
                        labelStyle: TextStyle(
                            fontSize: 16
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(30)
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),

          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context,index){
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context){
                            return ProductDetails(product: product);
                          })
                      );
                    },
                    child: productCard(
                        context,
                        title: product['title'],
                        price: product['price'],
                        img: product['imageUrl'],
                        backgroundColor: index.isEven
                            ? Color.fromRGBO(216, 240, 253, 1)
                            : Color.fromRGBO(245, 247, 249, 1)
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

Widget productCard(BuildContext context, {
  required String title,
  required double price,
  required String img,
  required Color backgroundColor
}){
  return Container(
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20)
    ),
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: .start,
      spacing: 5,
      children: [
        Text(
            title,
            style: Theme.of(context).textTheme.titleMedium
        ),
        Text("\$$price",style: Theme.of(context).textTheme.bodySmall),
        Center(child: Image.asset(img, height: 150))
      ],
    ),
  );
}
