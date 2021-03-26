import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramen/common/navigation.dart';
import 'package:ramen/common/result_state.dart';
import 'package:ramen/provider/db_provider.dart';
import 'package:ramen/ui/maps_page.dart';
import 'package:ramen/widget/dialog_ramen.dart';

class RamenPage extends StatefulWidget {

  static const routeName = '/ramen_page';

  @override
  _RamenPageState createState() => _RamenPageState();
}

class _RamenPageState extends State<RamenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ramen Stall Tracker"),
        actions: [
          Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              showDialog(context: context,
              barrierDismissible: true,
                builder: (BuildContext context){
                return DialogRamen();
                }
              );
            },
            child: Icon(
              Icons.add,
              size: 26.0,
              color: Colors.white,
            ),
          )
        ),
        ],
      ),
      body: Consumer<DatabaseProvider>(
        builder : (context, provider, child){
          if(provider.state == ResultState.Loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(provider.state == ResultState.HasData){
            return ListView.builder(
              itemCount: provider.ramen.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: Key(provider.ramen[index].id.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    provider.deleteRamen(provider.ramen[index].id);
                  },
                  child: InkWell(
                    onTap: (){
                      Navigation.intentWithData(MapsPage.routeName, MapsArgument(provider.ramen[index],  false));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(provider.ramen[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                                ),                      
                              ),
                              Spacer(),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 30.0,
                                color: Colors.grey,
                              )
                            ],  
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }else{
            return Center(
              child: Text("No Data",
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 16),
              ),
            );
          }
        }
      ),
    );
  }
}