import 'package:flutter/material.dart';
import '../services/panel_service.dart';

class ServersScreen extends StatefulWidget {
  const ServersScreen({super.key});

  @override
  State<ServersScreen> createState() => _ServersScreenState();
}


class _ServersScreenState extends State<ServersScreen> {

  List<VpnServer> servers = [];

  bool loading = true;


  @override
  void initState() {
    super.initState();
    loadServers();
  }


  void loadServers() async {

    final url =
    await PanelService.getSavedSubscriptionUrl();


    if (url != null) {

      final result =
      await PanelService.fetchServers(url);

      setState(() {

        servers = result;

        loading = false;

      });

    } else {

      setState(() {

        loading = false;

      });

    }

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor:
      const Color(0xff050505),


      appBar: AppBar(

        title: const Text(
          "سرورها",
        ),

      ),



      body:

      loading

      ? const Center(
        child:CircularProgressIndicator(),
      )


      :

      servers.isEmpty

      ? const Center(

        child: Text(
          "هیچ سروری پیدا نشد",
          style:TextStyle(
            color:Colors.white,
          ),
        ),

      )


      :

      ListView.builder(

        padding:
        const EdgeInsets.all(20),

        itemCount:
        servers.length,


        itemBuilder:(context,index){


          final server =
          servers[index];


          return Card(

            color:
            const Color(0xff151515),


            child:ListTile(

              title:Text(

                server.remark,

                style:
                const TextStyle(
                  color:Colors.white,
                ),

              ),


              subtitle:Text(

                server.protocol,

                style:
                const TextStyle(
                  color:Colors.grey,
                ),

              ),

            ),

          );

        },

      ),

    );

  }
}
