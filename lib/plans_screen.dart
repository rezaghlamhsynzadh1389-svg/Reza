import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  final List<Map<String,String>> plans = const [

    {
      "name":"10 گیگ",
      "price":"75,000 تومان",
      "time":"30 روزه"
    },

    {
      "name":"20 گیگ",
      "price":"140,000 تومان",
      "time":"30 روزه"
    },

    {
      "name":"30 گیگ",
      "price":"199,000 تومان",
      "time":"30 روزه"
    },

    {
      "name":"نامحدود",
      "price":"299,000 تومان",
      "time":"30 روزه"
    },

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff050505),

      appBar: AppBar(

        backgroundColor: Colors.transparent,

        title: const Text(
          "خرید اشتراک",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle:true,
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(20),

        itemCount: plans.length,

        itemBuilder:(context,index){

          return Container(

            margin: const EdgeInsets.only(bottom:20),

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: const Color(0xff151515),

              borderRadius: BorderRadius.circular(25),

              border: Border.all(
                color: Colors.purpleAccent,
                width:1,
              ),

            ),


            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,


              children:[


                Text(
                  plans[index]["name"]!,
                  style:const TextStyle(
                    color:Colors.white,
                    fontSize:24,
                    fontWeight:FontWeight.bold,
                  ),
                ),


                const SizedBox(height:10),


                Text(
                  plans[index]["price"]!,
                  style:const TextStyle(
                    color:Colors.purpleAccent,
                    fontSize:20,
                  ),
                ),


                Text(
                  plans[index]["time"]!,
                  style:const TextStyle(
                    color:Colors.grey,
                  ),
                ),


                const SizedBox(height:15),


                SizedBox(

                  width:double.infinity,

                  child:ElevatedButton(

                    style:ElevatedButton.styleFrom(

                      backgroundColor:
                      Colors.deepPurple,

                      padding:
                      const EdgeInsets.all(15),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(20),

                      ),
                    ),


                    onPressed:(){

                      // اتصال به درگاه پرداخت بعدا اضافه می‌شود

                    },


                    child:const Text(
                      "خرید اشتراک",
                      style:TextStyle(
                        color:Colors.white,
                        fontSize:18,
                      ),
                    ),

                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}
