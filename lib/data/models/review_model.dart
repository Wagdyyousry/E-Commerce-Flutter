class ReviewModel {
  String? userName,
      shopName,
      userImageUri,
      shopImageUri,
      userId,
      shopId,
      review,
      reply;
  double? reviewDate, replyDate, rating;
  ReviewModel({
    this.userName,
    this.userImageUri,
    this.shopImageUri,
    this.shopName,
    this.shopId,
    this.userId,
    this.review,
    this.reply,
    this.reviewDate,
    this.replyDate,
    this.rating,
  });

  factory ReviewModel.fromMap(Map<dynamic, dynamic> map) {
    return ReviewModel(
      userName: map['userName'],
      shopName: map['shopName'],
      userId: map['userId'],
      shopId: map['shopId'],
      shopImageUri: map['shopImageUri'],
      userImageUri: map['userImageUri'],
      review: map['review'],
      reply: map['reply'],
      reviewDate: map['reviewDate'],
      replyDate: map['replyDate'],
      rating: map['rating'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'shopName': shopName,
      'userId': userId,
      'shopId': shopId,
      'userImageUri': userImageUri,
      'shopImageUri': shopImageUri,
      'review': review,
      'reply': reply,
      'reviewDate': reviewDate,
      'replyDate': replyDate,
      'rating': rating,
    };
  }
}
