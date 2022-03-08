import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/screens/AppQustions/dating_question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Religion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
  return Religion_state();
  }

}
class Religion_state extends State<Religion>{
  int slectedIndex=0;
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  return Scaffold(appBar: AppBar(elevation: 0,backgroundColor: APP_PRIMARY_COLOR,),
    backgroundColor: APP_PRIMARY_COLOR,
    body:    Container(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("What's your Religion ?",
              textAlign: TextAlign.start,style: TextStyle(fontSize: 32,color: Colors.white,fontWeight: FontWeight.bold),),

          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.020,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Container(height: 50,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(suffixIcon: Icon(Icons.search,color: Colors.white,),
                  //   labelText: _i18n.translate("fullname"),
                  hintText: "Search Religion",
                  hintStyle: TextStyle(color: Colors.white),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),

              ),
            ),
          ),
          ListView.builder(shrinkWrap: true,scrollDirection: Axis.vertical,
              itemCount:datindQustions().QReligion.length ,
              itemBuilder: (context,index){
                return Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height:25,
                        child: ListTile(onTap: (){
                          setState(() {
                            slectedIndex =index;
                          });
                        },
                            trailing:slectedIndex==index?Icon(Icons.check):null ,
                            textColor: Colors.white,
                            selected: slectedIndex==index?true:false,

                            selectedColor: Colors.amber,



                            title: Text('${datindQustions().QReligion[index]}',textAlign: TextAlign.start,)),
                      ),
                      SizedBox(height: 8,),
                      Divider(thickness: 0.2,color: Colors.white,)
                    ],
                  ),
                ));

              })




        ],

      ),
    )),

  );
  }

}