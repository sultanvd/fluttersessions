// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';

import 'package:assignment4/model/CityItem.dart';
import 'package:assignment4/model/WeatherData.dart';
import 'package:assignment4/service/WeatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'package:assignment4/main.dart';

class MockClient extends Mock implements http.Client {}

void main() {

  testWidgets('Test Default Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Select City'), findsOneWidget);
    expect(find.text('N/A'), findsNWidgets(5));

  });


  testWidgets('Test Cities List', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Select City'), findsOneWidget);
    expect(find.text('N/A'), findsNWidgets(5));

    // Tap the 'select city button' icon and trigger a frame.
      await tester.tap(find.text('Select City'));
      await tester.pump();

    // Verify that city is shown.
    expect(find.text('Select City'), findsNWidgets(2));
    expect(find.text('Karachi'), findsNWidgets(2));
    expect(find.text('Lahore'), findsNWidgets(2));
    expect(find.text('Islamabad'), findsNWidgets(2));
    expect(find.text('Beijing'), findsNWidgets(2));
    expect(find.text('London'), findsNWidgets(2));
    expect(find.text('New York'), findsNWidgets(2));
    expect(find.text('Paris'), findsNWidgets(2));
  });


  group('loadCityDetails', (){

    test('returns Weather details if the http call completes successfully', () async {
      final mockClient = MockClient();

      String WEATHER_DETAILS_URL_KARACHI = 'http://api.openweathermap.org/data/2.5/weather?lat=24.882481&lon=67.075949&appid=d901ab865a4d576474d9368ecaa0d7ff';
      String WEATHER_DETAILS_RESPONSE = '{\"coord\":{\"lon\":67.08,\"lat\":24.88},\"weather\":[{\"id\":211,\"main\":\"Thunderstorm\",\"description\":\"thunderstorm\",\"icon\":\"11n\"}],\"base\":\"stations\",\"main\":{\"temp\":305.15,\"feels_like\":304.63,\"temp_min\":305.15,\"temp_max\":305.15,\"pressure\":1003,\"humidity\":59},\"visibility\":4000,\"wind\":{\"speed\":8.2,\"deg\":360},\"clouds\":{\"all\":40},\"dt\":1591459665,\"sys\":{\"type\":1,\"id\":7576,\"country\":\"PK\",\"sunrise\":1591404107,\"sunset\":1591453157},\"timezone\":18000,\"id\":1174872,\"name\":\"Karachi\",\"cod\":200}';

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(mockClient.get(WEATHER_DETAILS_URL_KARACHI))
          .thenAnswer((_) async => http.Response(WEATHER_DETAILS_RESPONSE, 200));
      client = mockClient;
      WeatherDataService service = WeatherDataService();
      CityItem city = CityItem("Karachi", 24.882481, 67.075949);
      expect(await service.loadCityDetails(city), isA<WeatherData>());
    });

  });


}
