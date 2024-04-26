class BrandModel {
  String? brandName, brandId, brandImageUri;
  BrandModel({this.brandName, this.brandImageUri, this.brandId});

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      brandName: map['brandName'],
      brandId: map['brandId'],
      brandImageUri: map['brandImageUri'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'brandName': brandName,
      'brandId': brandId,
      'brandImageUri': brandImageUri,
    };
  }
}
