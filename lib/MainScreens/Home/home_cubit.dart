import 'package:bloc/bloc.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:meta/meta.dart';

import 'Banners/BannersDatamdel.dart';
import 'HomepageModel/HomeModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Future<List<Bannerdata>?> getbanners()async{
    emit(LodingHomestate());
   try{
     final response=  await Apihelper.getData(path: "banners");
     if(response.statusCode==200){
       final data = Bannersdatamdel.fromJson(response.data);
       if(data.status??false){
       List<Bannerdata> data2;
       emit(succesHomestat());
       return  data2 = data.data;
       }

     }
     else {
       emit(errorHomestate("eroooor1"));
       return null ;
     }


   }catch(e){
     emit(errorHomestate(e.toString()));

   }
   return null;



  }
  Future<List<HomeProducts>?>getproducts()async{
    emit(LodingHomestate());
    try{
    final response = await Apihelper.getData(path: "home");
    print("response state =-========= ${response.statusCode}");
    if(response.statusCode==200)
      {
      final Homereponse=  HomeModel.fromJson(response.data);
      print("Homereponse state =-========= ${Homereponse.status}");

      if(Homereponse.status??false){
        List<HomeProducts>? data2;
       print( "nammmmmmmmmmmmmmmmmme ${Homereponse.data?.products.first.name}");
        emit(succesHomestat());
      return data2= Homereponse.data?.products;
      }
      else {emit(errorHomestate("erroooooor1"));
      print("errrrrrrrro1");}
      }

    }catch(e){
      emit(errorHomestate(e.toString()));
      print("errrrrro2"+e.toString());
    }
    return null;
  }
}
