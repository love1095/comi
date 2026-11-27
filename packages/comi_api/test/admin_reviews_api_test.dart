import 'package:test/test.dart';
import 'package:comi_api/comi_api.dart';


/// tests for AdminReviewsApi
void main() {
  final instance = ComiApi().getAdminReviewsApi();

  group(AdminReviewsApi, () {
    //Future<ReviewDto> adminReviewsDecide(String id, DecisionDto decisionDto) async
    test('test adminReviewsDecide', () async {
      // TODO
    });

    //Future<List<ReviewDto>> adminReviewsReported() async
    test('test adminReviewsReported', () async {
      // TODO
    });

  });
}
