import 'package:flutter/material.dart';

// 📱 Screen Imports
import 'screens/startup_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/lounge_home_page.dart';
import 'screens/register_lounge_page.dart';
import 'screens/lounge_photos_screen.dart';
import 'screens/passenger_booking_details.dart';
import 'screens/lounge_booking.dart';
import 'screens/bus_schedule_screen.dart';
import 'screens/marketplace_screen.dart';
import 'screens/payment_page.dart';
import 'screens/profile_page.dart';
import 'screens/settings_page.dart';
import 'screens/tuktuk_service_settings.dart';
import 'screens/lounge_approval.dart';
import 'screens/admin_registration.dart';
import 'screens/admin_home_page.dart';
import 'screens/admin_dashboard.dart';
import 'screens/staff_registration.dart';
import 'screens/staff_list_page.dart';
import 'screens/staff_registration_status.dart';
import 'screens/edit_marketplace.dart';
import 'screens/edit_lounge_page.dart';
import 'screens/lounge_details_screen.dart';
import 'screens/lounge_list_screen.dart';
import 'screens/welcome_page.dart';
import 'screens/photos_and_gallery_screen.dart';
import 'screens/register_lounge_location_page.dart';
import 'screens/location_contact_page.dart';
import 'screens/today_bookings_screen.dart';
import 'screens/received_food_screen.dart';
import 'screens/order_details_screen.dart';
import 'screens/add_tuk_tuk_page.dart';
import 'screens/tuk_tuk_list_page.dart';
import 'screens/qr_scanner_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 🧭 Route constants
  static const String routeStartup = '/';
  static const String routeLogin = '/login';
  static const String routeSignup = '/signup';
  static const String routeWelcome = '/welcome';

  static const String routeDashboard = '/dashboard';

  static const String routeLounge = '/lounge';
  static const String routeLoungeRegister = '/lounge/register';
  static const String routeLoungePhotos = '/lounge/photos';
  static const String routeLoungeBooking = '/lounge/booking';
  static const String routeLoungeDetails = '/lounge/details';
  static const String routeLoungeList = '/lounge/list';
  static const String routeEditLounge = '/lounge/edit';

  // ⭐ NEW ROUTE FOR LOCATION & CONTACT PAGE
  static const String routeLoungeLocation = '/lounge/location';
  static const String routeLoungeLocationContact = '/lounge/location-contact';
  static const String routeLoungePhotosGallery = '/lounge/photos-gallery';

  static const String routePassengerDetails = '/passenger/details';
  static const String routeBusSchedule = '/bus/schedule';
  static const String routeTodayBookings = '/today/bookings';
  static const String routeReceivedFood = '/received/food';
  static const String routeOrderDetails = '/order/details';

  static const String routeMarketplace = '/marketplace';
  static const String routeEditMarketplace = '/marketplace/edit';

  static const String routePayment = '/payment';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';
  static const String routeTukTukSettings = '/tuktuk/settings';

  static const String routeLoungeApproval = '/lounge/approval';

  static const String routeAdminRegister = '/admin/register';
  static const String routeAdminHome = '/admin/home';
  static const String routeAdminDashboard = '/admin/dashboard';

  static const String routeStaffRegister = '/staff/register';
  static const String routeStaffList = '/staff/list';
  static const String routeStaffStatus = '/staff/status';
  
  static const String routeAddTukTuk = '/tuktuk/add';
  static const String routeTukTukList = '/tuktuk/list';
  
  static const String routeQRScanner = '/qr/scanner';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Lounge App',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF8C1A),
          background: const Color(0xFFFFFBF5),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF5),
        useMaterial3: true,
      ),

      initialRoute: routeStartup,

      routes: {
        routeStartup: (context) => const StartupPage(),
        routeLogin: (context) => const LoginPage(),
        routeSignup: (context) => const SignupPage(),
        routeWelcome: (context) => const WelcomePage(),

        routeDashboard: (context) => const DashboardPage(),

        routeLounge: (context) => const LoungeHomePage(),
        routeLoungeRegister: (context) => const RegisterLoungePage(),
        routeLoungePhotos: (context) => const LoungePhotosScreen(),
        routeLoungeBooking: (context) => const LoungeBookingScreen(),
        routeEditLounge: (context) => const EditLoungePage(),
        routeLoungeDetails: (context) => const LoungeDetailsScreen(),
        routeLoungeList: (context) => const LoungeListScreen(),

        // ⭐ NEW ROUTES
        routeLoungeLocation: (context) => const LocationContactPage(),
        routeLoungeLocationContact: (context) => const RegisterLoungeLocationPage(),
        routeLoungePhotosGallery: (context) => const PhotosAndGalleryScreen(),

        routePassengerDetails: (context) => const PassengerBookingDetails(),
        routeBusSchedule: (context) => const BusScheduleScreen(),
        routeTodayBookings: (context) => const TodayBookingsScreen(),
        routeReceivedFood: (context) => const ReceivedFoodScreen(),
        routeOrderDetails: (context) => const OrderDetailsScreen(),

        routeMarketplace: (context) => const MarketplaceScreen(),
        routeEditMarketplace: (context) => const EditMarketplace(),

        routePayment: (context) => const PaymentPage(),
        routeProfile: (context) => const ProfilePage(),
        routeSettings: (context) => const SettingsPage(),
        routeTukTukSettings: (context) => const TukTukServiceSettingsPage(),

        routeLoungeApproval: (context) => const LoungeApprovalScreen(),
        routeAdminRegister: (context) => const AdminRegistrationPage(),
        routeAdminHome: (context) => const AdminHomePage(),
        routeAdminDashboard: (context) => const AdminDashboardPage(),

        routeStaffRegister: (context) => const StaffRegistrationPage(),
        routeStaffList: (context) => const StaffListPage(),
        routeStaffStatus: (context) => const StaffRegistrationStatus(),
        
        routeAddTukTuk: (context) => const AddTukTukPage(),
        routeTukTukList: (context) => const TukTukDetailPage(),
        
        routeQRScanner: (context) => const QRScannerScreen(),
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
              backgroundColor: const Color(0xFFFF8C1A),
            ),
            body: Center(
              child: Text(
                'Route "${settings.name}" not found!',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
