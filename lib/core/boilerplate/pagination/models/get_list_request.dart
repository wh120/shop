class GetListRequest{

  int? skipCount;
  int? maxResultCount;
  String? sorting;
  String? keyword;
  Map<String, dynamic>?  extraParams;

  GetListRequest(
      {this.skipCount,
        this.maxResultCount,
        this.sorting,
        this.keyword,
        this.extraParams}
        );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   if(this.skipCount !=null) data['skip'] = this.skipCount;
   if(this.maxResultCount !=null) data['limit'] = this.maxResultCount;
    if(this.sorting !=null) data['Sorting'] = this.sorting;
    if(this.keyword !=null) data['Keyword'] = this.keyword;
    if(extraParams != null) {
      data.addAll(extraParams ?? {});
    }
    return data;
  }
}