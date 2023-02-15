// import 'package:bloc/bloc.dart';
// import 'package:nuclear_treatment/core/API/CoreModels/base_response_model.dart';
// import 'package:nuclear_treatment/core/API/CoreModels/base_result_model.dart';
// import 'package:nuclear_treatment/core/API/errors/base_error.dart';
// import 'package:nuclear_treatment/core/Boilerplate/pagination/models/get_list_request.dart';
//  import 'package:nuclear_treatment/features/Notifications/data/models/Notification.dart';
// import 'package:nuclear_treatment/features/Notifications/domain/repository/NotificationRepository.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
//
// part 'base_state.dart';
//
// typedef RepositoryCallBack  = Future<BaseResultModel> Function( dynamic data);
//
// class BaseCubit<ListModel> extends Cubit<BaseState> {
//   BaseCubit() : super(BaseInitial());
//
//   List  list;
//   int maxResultCount = 20;
//   int skipCount = 0;
//
//
//   getList({ @required RepositoryCallBack getData,bool loadMore = false})async{
//
//     if(!loadMore)
//     {
//       skipCount = 0;
//       emit(Loading());
//     }
//     else
//       skipCount += maxResultCount;
//
//     var requestData = GetListRequest(
//         maxResultCount: maxResultCount,
//         skipCount: skipCount
//     );
//     var response = await getData(requestData);
//
//     if(response is ListResultModel)
//     {
//       if(loadMore)
//         list.addAll(response.list  );
//       else
//         list = response.list;
//
//       emit(GetListSuccessfully(
//           list: list ,
//         noMoreData:  response.list.length==0 &&loadMore
//       ));
//     }
//     else if(response is BaseError)  emit(Error( response.message));
//     else if (response is ServerError) emit(Error(response.message ));
//
//   }
//
// }
//
//
