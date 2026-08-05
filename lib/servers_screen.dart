import 'package:flutter/material.dart';

class ServersScreen extends StatelessWidget {
  const ServersScreen({super.key});

  final List<Map<String,String>> servers = const [
    {
      "name":"Germany 🇩🇪",
      "ping":"35 ms",
    },
    {
      "name":"Netherlands 🇳🇱",
      "ping":"45 ms",
    },
    {
      "name":"Finland 🇫🇮",
      "ping":"55 ms",
    },
    {
      "name":"Turkey 🇹🇷",
      "ping":"25 ms",
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff050505),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "انتخاب سرور",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle:true,
      ),


      body: ListView.builder(

        padding: const EdgeInsets.all(20),

        itemCount: servers.length,

        itemBuilder:(context,index){

          return Card(

            color: const Color(0xff151515),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: ListTile(

              leading: const Icon(
                Icons.public,
                color: Colors.purpleAccent,
              ),


              title: Text(
                servers[index]["name"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize:18,
                  fontWeight:FontWeight.bold,
                ),
              ),


              subtitle: Text(
                "Ping: ${servers[index]["ping"]}",
                style: const TextStyle(
                  color:Colors.grey,
                ),
              ),


              trailing: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.deepPurple,
                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(20),
                  ),
                ),

                onPressed:(){

                  Navigator.pop(context);

                },

                child:const Text(
                  "انتخاب",
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),

            ),
          );
        },
      ),
    );
  }
}
