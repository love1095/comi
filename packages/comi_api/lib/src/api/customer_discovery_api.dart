//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

// ignore: unused_import
import 'dart:convert';
import 'package:comi_api/src/deserialize.dart';
import 'package:dio/dio.dart';

import 'package:comi_api/src/model/home_dto.dart';
import 'package:comi_api/src/model/map_pin_dto.dart';
import 'package:comi_api/src/model/public_menu_category_dto.dart';
import 'package:comi_api/src/model/restaurant_detail_dto.dart';
import 'package:comi_api/src/model/restaurant_page_dto.dart';
import 'package:comi_api/src/model/suggest_dto.dart';

class CustomerDiscoveryApi {

  final Dio _dio;

  const CustomerDiscoveryApi(this._dio);

  /// discoveryDetail
  /// 
  ///
  /// Parameters:
  /// * [slug] 
  /// * [acceptLanguage] 
  /// * [acceptLanguage2] - vi | en | ko | zh | ja (fallback → en → vi)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RestaurantDetailDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RestaurantDetailDto>> discoveryDetail({ 
    required String slug,
    required String acceptLanguage,
    String? acceptLanguage2,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/restaurants/{slug}'.replaceAll('{' r'slug' '}', slug.toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        r'accept-language': acceptLanguage,
        if (acceptLanguage2 != null) r'Accept-Language': acceptLanguage2,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    RestaurantDetailDto? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<RestaurantDetailDto, RestaurantDetailDto>(rawData, 'RestaurantDetailDto', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RestaurantDetailDto>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// discoveryHome
  /// 
  ///
  /// Parameters:
  /// * [lat] 
  /// * [lng] 
  /// * [acceptLanguage] 
  /// * [acceptLanguage2] - vi | en | ko | zh | ja (fallback → en → vi)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [HomeDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<HomeDto>> discoveryHome({ 
    required num lat,
    required num lng,
    required String acceptLanguage,
    String? acceptLanguage2,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/home';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        r'accept-language': acceptLanguage,
        if (acceptLanguage2 != null) r'Accept-Language': acceptLanguage2,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lng': lng,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    HomeDto? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<HomeDto, HomeDto>(rawData, 'HomeDto', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<HomeDto>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// discoveryMap
  /// 
  ///
  /// Parameters:
  /// * [bbox] - minLng,minLat,maxLng,maxLat
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [List<MapPinDto>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<List<MapPinDto>>> discoveryMap({ 
    required String bbox,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/restaurants/map';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'bbox': bbox,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    List<MapPinDto>? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<List<MapPinDto>, MapPinDto>(rawData, 'List<MapPinDto>', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<List<MapPinDto>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// discoveryMenu
  /// 
  ///
  /// Parameters:
  /// * [id] 
  /// * [acceptLanguage] 
  /// * [acceptLanguage2] - vi | en | ko | zh | ja (fallback → en → vi)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [List<PublicMenuCategoryDto>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<List<PublicMenuCategoryDto>>> discoveryMenu({ 
    required String id,
    required String acceptLanguage,
    String? acceptLanguage2,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/restaurants/{id}/menu'.replaceAll('{' r'id' '}', id.toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        r'accept-language': acceptLanguage,
        if (acceptLanguage2 != null) r'Accept-Language': acceptLanguage2,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    List<PublicMenuCategoryDto>? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<List<PublicMenuCategoryDto>, PublicMenuCategoryDto>(rawData, 'List<PublicMenuCategoryDto>', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<List<PublicMenuCategoryDto>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// discoveryNearby
  /// 
  ///
  /// Parameters:
  /// * [lat] 
  /// * [lng] 
  /// * [acceptLanguage] 
  /// * [radius] - meters
  /// * [q] - name, accent-insensitive
  /// * [cuisine] - comma separated, e.g. com,nhau
  /// * [priceMax] 
  /// * [minRating] 
  /// * [openNow] 
  /// * [maxMainPrice] - \"Under 60k\": has a main dish at or below this price
  /// * [groupSize] - \"Groups 10+\"
  /// * [openLate] - Open until 23:00 or later today
  /// * [privateRoom] 
  /// * [mode] 
  /// * [sort] - score = rating weighted by review count and distance
  /// * [dietary] - Tourists: comma separated vegetarian,halal,no_pork,gluten_free
  /// * [availableAt] - Only restaurants with a free table at this time (ISO) — needs partySize
  /// * [partySize] - With availableAt
  /// * [cursor] - Offset from the previous page
  /// * [limit] 
  /// * [acceptLanguage2] - vi | en | ko | zh | ja (fallback → en → vi)
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [RestaurantPageDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<RestaurantPageDto>> discoveryNearby({ 
    required num lat,
    required num lng,
    required String acceptLanguage,
    num? radius = 3000,
    String? q,
    String? cuisine,
    num? priceMax,
    num? minRating,
    bool? openNow,
    num? maxMainPrice,
    num? groupSize,
    bool? openLate,
    bool? privateRoom,
    String? mode,
    String? sort,
    String? dietary,
    String? availableAt,
    num? partySize,
    num? cursor,
    num? limit = 20,
    String? acceptLanguage2,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/restaurants';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        r'accept-language': acceptLanguage,
        if (acceptLanguage2 != null) r'Accept-Language': acceptLanguage2,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lng': lng,
      if (radius != null) r'radius': radius,
      if (q != null) r'q': q,
      if (cuisine != null) r'cuisine': cuisine,
      if (priceMax != null) r'priceMax': priceMax,
      if (minRating != null) r'minRating': minRating,
      if (openNow != null) r'openNow': openNow,
      if (maxMainPrice != null) r'maxMainPrice': maxMainPrice,
      if (groupSize != null) r'groupSize': groupSize,
      if (openLate != null) r'openLate': openLate,
      if (privateRoom != null) r'privateRoom': privateRoom,
      if (mode != null) r'mode': mode,
      if (sort != null) r'sort': sort,
      if (dietary != null) r'dietary': dietary,
      if (availableAt != null) r'availableAt': availableAt,
      if (partySize != null) r'partySize': partySize,
      if (cursor != null) r'cursor': cursor,
      if (limit != null) r'limit': limit,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    RestaurantPageDto? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<RestaurantPageDto, RestaurantPageDto>(rawData, 'RestaurantPageDto', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<RestaurantPageDto>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// discoverySuggest
  /// 
  ///
  /// Parameters:
  /// * [q] 
  /// * [lat] 
  /// * [lng] 
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [SuggestDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<SuggestDto>> discoverySuggest({ 
    required String q,
    num? lat,
    num? lng,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/search/suggest';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[],
        ...?extra,
      },
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'q': q,
      if (lat != null) r'lat': lat,
      if (lng != null) r'lng': lng,
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    SuggestDto? _responseData;

    try {
final rawData = _response.data;
_responseData = rawData == null ? null : deserialize<SuggestDto, SuggestDto>(rawData, 'SuggestDto', growable: true);

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<SuggestDto>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
