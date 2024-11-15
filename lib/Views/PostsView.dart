import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premios_celo/FbObjects/FbPost.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';
import 'package:premios_celo/Views/LoginView.dart';
import 'package:premios_celo/Views/SplashView.dart';

import '../Items/PostItem.dart';

class PostsView extends StatefulWidget{

  final Function(int i) onMasDatosClicked;

  PostsView({super.key,required this.onMasDatosClicked});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {

  List<FbPost> arPosts=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async{
    List<FbPost> arTemp=await DataHolder().descargarTodosPosts(true);

    if(arTemp.isNotEmpty){
      arPosts.clear();
      setState((){
        arPosts.addAll(arTemp);
      });
    }
  }

  Widget? celdaBuilder(BuildContext contexto, int indice){
    return PostItem(
        sTitulo: arPosts[indice].sTitulo,
        sBody: arPosts[indice].sCuerpo,
        sUrlImg: arPosts[indice].sImgUrl,
        iIndice: indice,
        onMasDatosClicked:widget.onMasDatosClicked
    );
  }

  Widget? gridCeldaBuilder(BuildContext contexto, int indice){

    return Stack(
      children: [
        Image.network("https://media.licdn.com/dms/image/v2/C5603AQH4zLBGlQOfiA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1548413104846?e=2147483647&v=beta&t=2zEQPtmi4vZRkbGmm-GnLrE2AshlmVDozGjWAM0fjV0"),
        Text("${arPosts[indice]}")
      ],
    );
  }

  Widget separatorBuilder(BuildContext contexto, int indice){
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up)),
        Text("1450"),
        IconButton(onPressed: (){}, icon: Icon(Icons.thumb_down)),
        Text("623"),
        IconButton(onPressed: (){}, icon: Icon(Icons.share)),
      ],
    );



    //return SplashView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: const Color(0xFF42A5F5),
      child:
        //ListView.builder(itemCount: arPosts.length, itemBuilder: celdaBuilder,)
      ListView.separated(itemCount: arPosts.length, itemBuilder: celdaBuilder,separatorBuilder: separatorBuilder,)
      //GridView.builder(itemCount: arPosts.length, itemBuilder: gridCeldaBuilder,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), )

      /*ListView(

        children: const [
          PostItem(sTitulo: "Titulo Post1",sBody: "Cuerpo Post1",sUrlImg:"https://media.licdn.com/dms/image/v2/C5603AQH4zLBGlQOfiA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1548413104846?e=2147483647&v=beta&t=2zEQPtmi4vZRkbGmm-GnLrE2AshlmVDozGjWAM0fjV0" ,),
          PostItem(sTitulo: "Titulo Post2",sBody: "Cuerpo Post2",sUrlImg:"https://media.licdn.com/dms/image/v2/C5603AQH4zLBGlQOfiA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1548413104846?e=2147483647&v=beta&t=2zEQPtmi4vZRkbGmm-GnLrE2AshlmVDozGjWAM0fjV0" ,),
          PostItem(sTitulo: "Titulo Post3",sBody: "Cuerpo Post3",sUrlImg:"https://media.licdn.com/dms/image/v2/C5603AQH4zLBGlQOfiA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1548413104846?e=2147483647&v=beta&t=2zEQPtmi4vZRkbGmm-GnLrE2AshlmVDozGjWAM0fjV0" ,),
          PostItem(sTitulo: "Titulo Post4",sBody: "Cuerpo Post4",sUrlImg:"https://media.licdn.com/dms/image/v2/C5603AQH4zLBGlQOfiA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1548413104846?e=2147483647&v=beta&t=2zEQPtmi4vZRkbGmm-GnLrE2AshlmVDozGjWAM0fjV0" ,),
        ],
      ),*/
    );
  }
}