import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';


import '../../../widgets/errors/base_error_widget.dart';
import '../../../widgets/errors/no_data_widget.dart';
import '../../../widgets/loading_footer.dart';
import '../cubits/pagination_cubit.dart';

typedef void CreatedCallback(PaginationCubit cubit);

typedef ListBuilder<Model> = Widget Function(List<Model> list);

//typedef AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);

class PaginationList<Model> extends StatefulWidget {
  final RepositoryCallBack? repositoryCallBack;
  final ListBuilder<Model>? listBuilder;
  final CreatedCallback? onCubitCreated;
  final bool? withPagination;
  final bool withEmptyWidget;
  final Map<String, dynamic>? initialParam;
  final VoidCallback? onRefresh;
  final Axis scrollDirection;
  final Widget? errorWidget;
  final Widget? noDataWidget;
  PaginationList(
      {Key? key,
        this.noDataWidget,
        this.errorWidget,
      this.scrollDirection = Axis.vertical,
      this.repositoryCallBack,
      this.listBuilder,
      this.withPagination = false,
      this.onCubitCreated,
      this.initialParam,
      this.withEmptyWidget = true,
      this.onRefresh})
      : super(key: key);

  @override
  _PaginationListState<Model> createState() => _PaginationListState<Model>();
}

class _PaginationListState<Model> extends State<PaginationList<Model>> {
  RefreshController _refreshController = RefreshController();
  PaginationCubit<Model>? cubit;

  @override
  void initState() {
    cubit = PaginationCubit<Model>(widget.repositoryCallBack!);
    if (widget.onCubitCreated != null) {
      widget.onCubitCreated!(cubit!);
    }
    cubit?.getList(param: widget.initialParam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildConsumer();
  }

  _buildConsumer() {
    return BlocConsumer<PaginationCubit<Model>, PaginationState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is Error) {
            // ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message));
          } else if (state is GetListSuccessfully) {
            if (widget.onRefresh != null) widget.onRefresh!();
            _refreshController.refreshCompleted();
            if (state.noMoreData)
              _refreshController.loadNoData();
            else
              _refreshController.loadComplete();
          }
        },
        builder: (context, state) {
          print('fromPagination builder');
          print(state);
          if (state is Loading)
            return Center(child: CupertinoActivityIndicator(radius: 15));
          else if (state is GetListSuccessfully) {
            return smartRefresher(state.list as List<Model>);
          } else if (state is Error) {
            return widget.errorWidget ?? BaseErrorWidget(
              title: state.message,
              onTap: () {
                cubit?.getList();
              },
            );
          } else
            return Container();
        });
  }

  smartRefresher(List<Model> list) {
    Widget child;
    if (list.length == 0 && widget.withEmptyWidget)
      child = widget.noDataWidget ?? NoDataWidget();
    else
      child = widget.listBuilder!(list);

    return SmartRefresher(
      scrollDirection: widget.scrollDirection,
      enablePullDown: widget.scrollDirection == Axis.vertical,
      enablePullUp: widget.scrollDirection == Axis.vertical,
      header: MaterialClassicHeader(),
      controller: _refreshController,
      onRefresh: () async {
        cubit?.getList();
      },
      onLoading: () async {
        cubit?.getList(loadMore: true);
      },
      child: child,
      footer: customFooter,
    );
  }
}
