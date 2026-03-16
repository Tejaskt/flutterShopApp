import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  
  int selectedSize = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Details')
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageUrl']),
          ),
          Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(40))
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Text('\$${widget.product['price']}', style: Theme.of(context).textTheme.titleLarge),

                SizedBox(height: 10),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index){
                      final size =  (widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {});
                              selectedSize = size;
                            },
                            child: Chip(
                              backgroundColor: selectedSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                                label: Text(size.toString())
                            ),
                          ),
                        );
                      }
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: (){
                      if(selectedSize != 0){
                        Provider.of<CartProvider>(context,listen: false)
                            .addProduct({
                          'id': widget.product['id'],
                          'title' : widget.product['title'],
                          'price' : widget.product['price'],
                          'imageUrl' : widget.product['imageUrl'],
                          'company' : widget.product['company'],
                          'sizes' : selectedSize,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Product added successfully!'))
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Select a size!'))
                        );
                      }
                    },
                    icon: Icon(Icons.shopping_cart,color: Colors.black),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size(.infinity,50)
                    ),
                    label: Text("Add to Cart",style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
