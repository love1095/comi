import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for RestaurantReviewsApi
void main() {
  final instance = ComiApi().getRestaurantReviewsApi();

  group(RestaurantReviewsApi, () {
    //Future<ReviewPageDto> restaurantReviewsList(String xRestaurantId, { String cursor }) async
    test('test restaurantReviewsList', () async {
      // TODO
    });

    //Future<ReviewDto> restaurantReviewsReply(String id, String xRestaurantId, ReplyDto replyDto) async
    test('test restaurantReviewsReply', () async {
      // TODO
    });

    //Future<ReviewDto> restaurantReviewsReport(String id, String xRestaurantId, ReportDto reportDto) async
    test('test restaurantReviewsReport', () async {
      // TODO
    });

  });
}
