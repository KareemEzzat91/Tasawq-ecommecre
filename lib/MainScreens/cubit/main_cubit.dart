import 'package:bloc/bloc.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:ecommerce/Api_List/KAPI.dart';
import 'package:meta/meta.dart';

import 'SearchModel/SearchModel.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  SearchModel searchModel = SearchModel();

  Future<List<Details>?> getsearch(String query) async {
    emit(MainLoading());
    try {
      final response = await Apihelper.postData(path: "products/search", body: {"text": query});
      print("Status Code: ${response.statusCode} +++++++++++++");
      if (response.statusCode == 200) {
        searchModel = SearchModel.fromJson(response.data);
        print("Status Code: ${response.data} ===========");
        print("SsearchModel.status: ${searchModel.status} +++++++++++++");

        if (searchModel.status ?? false) {
          final List<Details>? list = searchModel.data?.data;
          emit(MainLoaded());
          return list;
        }
      } else {
        emit(MainError("Error"));
      }
    } catch (e) {
      emit(MainError(e.toString()));
    }
    return null;
  }
}
