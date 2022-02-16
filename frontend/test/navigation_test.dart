import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/Screens/LoginScreen.dart';
import 'package:frontend/Screens/QuestionPage.dart';
import 'package:frontend/ViewModel/question_state.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// import 'main_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginScreen navigation tests', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    MaterialApp testMainViewWidget(Widget widget) {
    return MaterialApp(      
      home: ChangeNotifierProvider(
          create: (context) => QuestionState(), child: widget,
          ),
          navigatorObservers: [mockObserver],
    );
  }

    Future<void> _buildLoginScreen(WidgetTester tester) async {
      // await tester.pumpWidget(MaterialApp(
      //   home: LoginScreen(),

      //   // This mocked observer will now receive all navigation events
      //   // that happen in our app.
      //   navigatorObservers: [mockObserver],
      // ));
      await tester.pumpWidget(testMainViewWidget(LoginScreen()));

      // The tester.pumpWidget() call above just built our app widget
      // and triggered the pushObserver method on the mockObserver once.
      // verify(mockObserver.didPush(any!, any));
    }

    Future<void> _navigateToDetailsPage(WidgetTester tester) async {
      // Tap the button which should navigate to the details page.
      //
      // By calling tester.pumpAndSettle(), we ensure that all animations
      // have completed before we continue further.
      await tester.tap(find.byKey(LoginScreen.navigateToDetailsButtonKey));
      // await tester.pumpAndSettle();
      await tester.pump();
    }

    testWidgets(
        'when tapping "navigate to details" button, should navigate to details page',
        (WidgetTester tester) async {
      // await _buildLoginScreen(tester);
      await tester.pumpWidget(testMainViewWidget(LoginScreen()));
      await _navigateToDetailsPage(tester);

      // By tapping the button, we should've now navigated to the details
      // page. The didPush() method should've been called...
      // verify(mockObserver.didPush(any!, any));
      expect(find.byType(QuestionPage), findsOneWidget);

      // ...with the message we sent from main page.
      expect(find.text('まさとだよ'), findsOneWidget);
    });
  });
}
