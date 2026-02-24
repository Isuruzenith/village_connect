import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/language_selector_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/registration_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/chatbot/screens/chatbot_screen.dart';
import '../../features/community/screens/add_community_post_screen.dart';
import '../../features/community/screens/community_feed_screen.dart';
import '../../features/documents/screens/document_request_screen.dart';
import '../../features/documents/screens/request_detail_screen.dart';
import '../../features/documents/screens/request_tracking_screen.dart';
import '../../features/help/screens/help_screen.dart';
import '../../features/home/screens/app_shell.dart';
import '../../features/home/screens/citizen_home_screen.dart';
import '../../features/notices/screens/notice_board_screen.dart';
import '../../features/notices/screens/notice_detail_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/official/screens/official_dashboard_screen.dart';
import '../../features/official/screens/pending_requests_screen.dart';
import '../../features/official/screens/post_notice_screen.dart';
import '../../features/official/screens/request_review_screen.dart';
import '../../features/profile/screens/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/auth/language',
      builder: (context, state) => const LanguageSelectorScreen(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => const RegistrationScreen(),
    ),

    // Shell Route for Bottom Navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const CitizenHomeScreen(),
            ),
          ],
        ),
        // Notifications Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notifications',
              builder: (context, state) => const NotificationsScreen(),
            ),
          ],
        ),
        // Placeholder for FAB (handled in AppShell)
        StatefulShellBranch(
           routes: [
             GoRoute(
               path: '/fab-placeholder',
               builder: (context, state) => const SizedBox(),
             )
           ]
        ),
        // Notices Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notices',
              builder: (context, state) => const NoticeBoardScreen(),
            ),
          ],
        ),
        // Help Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/help',
              builder: (context, state) => const HelpScreen(),
            ),
          ],
        ),
      ],
    ),

    // Other routes (push on top of shell)
    GoRoute(
      path: '/chatbot',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ChatbotScreen(),
    ),
    GoRoute(
      path: '/documents/request',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DocumentRequestScreen(),
    ),
    GoRoute(
      path: '/documents/tracking',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RequestTrackingScreen(),
    ),
    GoRoute(
      path: '/documents/detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>? ?? {};
        return RequestDetailScreen(
          trackingId: extras['trackingId'] as String? ?? '',
          documentType: extras['documentType'] as String? ?? '',
          status: extras['status'] as String? ?? '',
        );
      },
    ),
    GoRoute(
      path: '/community',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const CommunityFeedScreen(),
    ),
    GoRoute(
      path: '/community/add',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AddCommunityPostScreen(),
    ),
    GoRoute(
      path: '/official/dashboard',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const OfficialDashboardScreen(),
    ),
    GoRoute(
      path: '/official/pending',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PendingRequestsScreen(),
    ),
    GoRoute(
      path: '/official/review',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RequestReviewScreen(),
    ),
    GoRoute(
      path: '/official/post-notice',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PostNoticeScreen(),
    ),
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/notice-detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final notice = state.extra as Map<String, String>;
        return NoticeDetailScreen(notice: notice);
      },
    ),
  ],
);
