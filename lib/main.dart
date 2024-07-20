import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/screen_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainApp());
}

class SwipeCard extends StatefulWidget {
  const SwipeCard({super.key});

  @override
  _SwipeCardState createState()=> _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard>{
  List<SwipeItem> _swipeItems= <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = [ 'Red','Blue','Green','Orange',];
  List <Color> _TextUtils=[
    TextUtils.red,
    TextUtils.blue,
    TextUtils.green,
    TextUtils.yellow,
    TextUtils.orange,
  ];

  @override
  void initState(){
    for(int i=0; i< _names.length ;i++){
      _swipeItems.add(SwipeItem(
        content:Content(text:_names[i],color:_TextUtils[i]),
        likeAction:(){
          ScaffoldMessanger.of(context).showSnackBar(SnackBar(
            content:Text('Nope  ${_names[i]}'),
          ));
        }

        nopeAction:(){
        ScaffoldMessanger.of(context).showSnackBar(SnackBar(
          content:Text('Nope ${_names[i]}'),
          duration:Duration(milliseconds: 500),
        ));
        },
      superlikeAction:(){
        ScaffoldMessanger.of(context).showSnackBar(SnackBar(
          content:Text('Superlikes ${_names[i]}',),
          duration:Duration(milliseconds: 500),
        ));
      }));
}

    _matchEngine =MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key:_scaffoldKey,
      appBar:AppBar(
        title:'Animated Swipe Cards',
        left:(){
          setState((){
            Get.back();
          });
        },
    right:(){
      setState((){
        String code='';
        Navigator.push(context,MaterialPageRoute(
          builder:(context)=>CodeViewScreen('Swipe Cards',)));
      });
    }
      ),

 backgroundColo:Get.isDarkMode? TextUtils.darkColor: TextUtils.primaryColor,
 body:Container(
  child:Column(
    Container(
      height:550,
      child:SwipeCards(
        matchEngine:_matchEngine!,
        itemBuilder:(BuildContext context,int index){
          return Container(
            alignment:Alignment.center,
            color:_swipeItems[index].content.color,
            child:Text(
              _swipeItems[index].content.text,
              style:TextStyle(fontSize:size100,color:TextUtils.white),
            ),
          );
        },
      onStackFinished:(){
        ScaffoldMessanger.of(context).showSnackBar(SnackBar(
          content:Text('Finished'),
          duration:Duration(milliseconds: 500),
        ));
      },
    ),
  ),
  Row(
    mainAxisAlignment:MainAxisAlignment.spaceEvenly,
    children:[
      MaterialButton(
        onPressed:(){
      _matchEngine!.currentItem!.nope();
        },
        child:Text( 
          'Nope',
          style:TextStyle(color:TextUtls.white),
        ),
      elevation:5,
      color:TextUtils.green,
      ),
    MaterialButton(
      onPressed:(){
        _matchEngine!.currentItem!.superLike();
      },
      child:Text(
        'Super;ike',
        style:TextStyle(color:TextUtils.black),
        ),
     elevation:5,
      color:TextUtils.white,
      ),
     MaterialButton(
      onPressed:(){
        _matchEngine!.currentItem!.like();
      },
      child:Text(
        'Like',
        style:TextStyle(color:TextUtils.white),
        ),
     elevation:5,
      color:TextUtils.orange,
      )
    ],
  )
  ),
    ),
    );
  }
}
 
 class Content{
  final String? text;
  final Color? color;

  Content({this.text,this.color});
 }