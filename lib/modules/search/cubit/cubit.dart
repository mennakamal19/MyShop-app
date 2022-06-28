import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myshop_app/models/search_model.dart';
import 'package:myshop_app/modules/search/cubit/states.dart';
import 'package:myshop_app/shared/components/constants.dart';
import 'package:myshop_app/shared/network/end_points.dart';
import 'package:myshop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}