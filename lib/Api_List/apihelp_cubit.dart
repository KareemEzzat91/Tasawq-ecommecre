import 'package:bloc/bloc.dart';
import 'package:ecommerce/Api_List/ApiHelper.dart';
import 'package:meta/meta.dart';

part 'apihelp_state.dart';

class ApihelpCubit extends Cubit<ApihelpState> {
  ApihelpCubit() : super(ApihelpInitial());

  void getnotifications (){
        Apihelper.getData(path:  "notifications");
      }

}
