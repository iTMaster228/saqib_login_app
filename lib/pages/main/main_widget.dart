
import 'dart:convert';
import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';
export 'main_model.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late MainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool isloading = true;
  AdmobBannerSize? bannerSize;
   late AdmobInterstitial interstitialAd;
  
  List<String> products = [
  'Safelite',
  'Five Guys',
  'Bed Bath & Beyond',
  "Bob's discount furniture",
  'GNC',
  'Nike',
  'dyson',
  'Keurig',
  // Add more countries...
];
 

  times_counter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
int nbTimesLaunched = (prefs.getInt('nbTimesLaunched') ?? 0) + 1;
await prefs.setInt('nbTimesLaunched', nbTimesLaunched);

  if(nbTimesLaunched >= 5){
     showDialog(context: context, builder: (BuildContext context) { 
      return AlertDialog(
         title: Text("Did we help you save money on deals, rewards, and cash back?"),
         content: Text("Help us help others by writing a review.\nWe appreciate your input to help us improve."),
         actions: [
          MaterialButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel"),),
          MaterialButton(onPressed: (){
              if (Platform.isAndroid || Platform.isIOS) {
  final appId = Platform.isAndroid ? 'com.my.cashsaver' : 'com.my.cashsaver';
  final url = Uri.parse(
    Platform.isAndroid
        ? "market://details?id=$appId"
        : "https://apps.apple.com/app/id$appId",
  );
  launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}
          }, child: Text("Rate", style: TextStyle(color: Colors.orangeAccent),),)
         ],
      );
      }, );
     await prefs.setInt('nbTimesLaunched', 0);
  }
  }


  List<Map<String, dynamic>> data = [];

    get_data() async {
     // interstitialAd.show();
      http.Response res = await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbzEajLcFhDK96Yb8gRzqy-vzqba_fLVFsC_Xk4vcPeaaXahklV_JAq5YLXbv66dP-ZK/exec"));
        if (res.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(res.body);
      final List<Map<String, dynamic>> parsedData = jsonResponse.cast<Map<String, dynamic>>();

      setState(() {
        data = parsedData;
         interstitialAd.show();
      });
    } else {
      throw Exception('Failed to load data');
    }

      setState(() {
       
        isloading =false;
      
       print("Loading Successfully ${data.length}");
      });
    }

        search_data(String query) async {
          isloading= true;
      http.Response res = await http.get(Uri.parse("https://script.google.com/macros/s/AKfycbwzHUYhux7rTzzhSiwgU26vDGz0s3FoRwY4GxImsFeD4lMMvat8hA0W41r0Nl-sJsCu/exec?filterColumn=Vendor&filterValue=${query}"));
       if (res.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(res.body);
      final List<Map<String, dynamic>> parsedData = jsonResponse.cast<Map<String, dynamic>>();

      setState(() {
        data = parsedData;
      });
    } else {
      throw Exception('Failed to load data');
    }
      setState(() {
      
        isloading =false;
       print("Loading Successfully ${data.length}");
      });
    }

  @override
  void initState() {
    super.initState();
    get_data();
   times_counter();
    bannerSize = AdmobBannerSize.BANNER;
     interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-2475878585028006/9772763876",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
       
      },

    );

    interstitialAd.load();
    _model = createModel(context, () => MainModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultcfk = await SearchableCall.call();
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }


bool _adShown=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 208, 208),
      appBar: AppBar(title: Text(""),
      backgroundColor: Colors.deepOrange,
      actions: [
        Padding(

          padding: const EdgeInsets.only(right:8.0),
          child: InkWell(
            onTap: (){
               context.pushNamed(
                                        'Profile',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.leftToRight,
                                            duration:
                                                Duration(milliseconds: 0),
                                          ),
                                        },
                                      );
            },
            child: Icon(Icons.settings)),
        )
        ],
      bottom: PreferredSize(preferredSize: Size.fromHeight(110.0),
      child: customAppBar()),
      ),


      body: Center(
        child: (isloading) ? CircularProgressIndicator(color: Colors.deepOrange,) :
         Column(
           children: [
           
           (_adShown)? Container(
              margin: EdgeInsets.only(top: 5),
              child: AdmobBanner(adUnitId: "ca-app-pub-2475878585028006/3703261116",
              adSize: AdmobBannerSize.SMART_BANNER(context),
              listener: (AdmobAdEvent event,m){
                if (event == AdmobAdEvent.loaded) {
                      setState(() {
                        _adShown=true;
                      });
                    } else if (event == AdmobAdEvent.failedToLoad) {
                      setState(() {
                        _adShown = false;
                      });
                    }
              }),
              
            ) : Container(),
             Expanded(
               child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) { 
                       final item = data[index];
                    return Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      
                      child: Column(
                       
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 211, 208, 208),
                            margin: EdgeInsets.only(left: 10, top: 5),
                            width: MediaQuery.of(context).size.width*1,
                            child: Text(data[index]['Vendor'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black),)),
                          Card(
                              elevation: 3,
                              child: Column( 
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: item.keys
                              .where((key) => key != 'Vendor')
                              .map((key) =>
                                  Container(
                                    margin: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       
                                        Text('$key'),
                                        
                                        (item[key]) < 1 ? Text("${(item[key]*100).toStringAsFixed(0)}%") :
                                        Text("\$${item[key].toStringAsFixed(0)}")
                                      ],
                                    ),
                                  )
                                  
             
                                  )
             
                              .toList(),
                              
                              
                              ),
                            
                          ),
                        ],
                      ),
                    );
                  
                   },),
             ),
           ],
         )
         
      )
    );
    
  }
   Widget customAppBar(){
     return Row(children: [
      Container(
        child: Image.asset("assets/Saver.png" ,width: 100, height: 100,),
        margin: EdgeInsets.all(10),
        ),
     Container(
      margin: EdgeInsets.only(left: 5,top:15),
      width: MediaQuery.of(context).size.width*0.65,
       child: Column(
         children: [
           TypeAheadField(
             textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        autocorrect: true,
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Product',
                          filled: true,
                          
                          prefixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ), suggestionsCallback: (String pattern) { 
                        return products
                          .where((country) => country.toLowerCase().contains(pattern.toLowerCase()))
                          .toList();
                       },
                       itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      // Handle when a suggestion is selected.
                     search_data(suggestion);
                      _controller.text = suggestion;
                      print('Selected country: $suggestion');
                    },
           ),
           Container(
            margin:EdgeInsets.only(left: 10, top: 7),
            child: Text("Activate deal in your card/bank app before using the card for purchase", style: TextStyle(color: Colors.white),))
         ],
       ),
     ),
     
     ],);

     
  }
}
