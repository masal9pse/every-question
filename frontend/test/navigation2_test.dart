import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/ViewModel/question_state.dart';
import 'package:frontend/main2.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('MainPageにproviderを追加', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider<QuestionState>(
            create: (context) => QuestionState(), child: MainPage()),

        // This mocked observer will now receive all navigation events
        // that happen in our app.
        navigatorObservers: [mockObserver],
      ));

      // The tester.pumpWidget() call above just built our app widget
      // and triggered the pushObserver method on the mockObserver once.
      // verify(mockObserver.didPush(any, any));
    }

    Future<void> _navigateToDetailsPage(WidgetTester tester) async {
      // Tap the button which should navigate to the details page.
      //
      // By calling tester.pumpAndSettle(), we ensure that all animations
      // have completed before we continue further.
      await tester.tap(find.byKey(MainPage.navigateToDetailsButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'when tapping "navigate to details" button, should navigate to details page',
        (WidgetTester tester) async {
      // TODO: Write the test case here.
      await _buildMainPage(tester);
      await _navigateToDetailsPage(tester);

      // By tapping the button, we should've now navigated to the details
      // page. The didPush() method should've been called...
      // verify(mockObserver.didPush(any!, any));
      // ...and there should be a DetailsPage present in the widget tree...
      expect(find.byType(DetailsPage), findsOneWidget);

      // ...with the message we sent from main page.
      expect(find.text('Hello!'), findsOneWidget);
    });
  });
}