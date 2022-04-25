
import 'package:dating_app/helpers/app_localizations.dart';
import 'package:dating_app/models/app_model.dart';
import 'package:dating_app/models/user_model.dart';
import 'package:dating_app/screens/Payment/Payment.dart';
import 'package:dating_app/screens/Payment/razerpay.dart';
import 'package:dating_app/widgets/store_products.dart';
import 'package:flutter/material.dart';

class VipDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child:Container(
          child: ListView(shrinkWrap: true,scrollDirection: Axis.vertical,
              children:[

                Container(

                  child: Column(
                    children: <Widget>[
                      /// User image

                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Upgrade to Premium",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                      ),

                      SizedBox(height: 8)
                    ],
                  ),
                ),


                      /// VIP Benefits
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("become a premiun member then you can get \n unlimited  swipes ans she who likes you and \n you can chat anyone directly get advanced filters ",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.normal)),
                            ),


                            // Passport
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
                    child: Container(decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.0
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0) //                 <--- border radius here
                      ),
                    ),
                        child: ListTile(leading: Text("1 month"),trailing: Text("199 Rs"),)),
                  ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Container(decoration: BoxDecoration(
    border: Border.all(
    width: 1.0
    ),
    borderRadius: BorderRadius.all(
    Radius.circular(5.0) //                 <--- border radius here
    ),
    ),
    child:   ListTile(selectedTileColor: Colors.amber,
      leading: Text("3 month"),trailing: Text("500 Rs"),),),),

    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 5),
    child: Container(decoration: BoxDecoration(
    border: Border.all(
    width: 1.0
    ),
    borderRadius: BorderRadius.all(
    Radius.circular(5.0) //                 <--- border radius here
    ),
    ),
    child:    ListTile(leading: Text("6 month"),trailing: Text("1000 Rs"),),),),

                            // Add more pictures



                            /// See disliked profiles


                            Center(child: RaisedButton(color: Color(0xffC5204C),
                              onPressed: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Payment(
                                      onFinish: (number) async {
                                        // payment done
                                        final snackBar = SnackBar(
                                          content: Text("Payment done Successfully"),
                                          duration: Duration(seconds: 5),
                                          action: SnackBarAction(
                                            label: 'Close',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        //     _scaffoldKey.currentState!.showSnackBar(snackBar);
                                        print('order id: ' + number);
                                        print('ddasdas');
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Text("Continue to Pay",style: TextStyle(color:Colors.white),),)),
                            SizedBox(height: 15)
                          ],
                        ),
                      )
                    ],

              ))


    );
  }
 }
