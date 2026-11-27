import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for CustomerReviewsApi
void main() {
  final instance = ComiApi().getCustomerReviewsApi();

  group(CustomerReviewsApi, () {
    //Future<ReviewDto> reviewsCreate(String id, CreateReviewDto createReviewDto) async
    test('test reviewsCreate', () async {
      // TODO
    });

    //Future<ReviewPageDto> reviewsList(String id, { String cursor }) async
    test('test reviewsList', () async {
      // TODO
    });

    //Future<ReviewDto> reviewsMine(String id) async
    test('test reviewsMine', () async {
      // TODO
    });

  });
}
