# Flutter API Integration Guide

## Overview
This document explains the API integration implemented in the Bus Lounge Flutter app.

## What Was Integrated

### 1. **Dashboard Page** (`dashboard_page.dart`)
**Integrated Endpoints:**
- `GET /api/v1/dashboard/stats` - Get dashboard statistics

**Features:**
- Real-time loading of dashboard metrics
- Pull-to-refresh functionality
- Error handling with retry option
- Auto-refresh button in app bar

**API Data Displayed:**
- Current Bookings (live count)
- Upcoming Bookings (live count)
- Today's Revenue (LKR amount)
- Occupancy Rate (percentage)

### 2. **Lounge Home Page** (`lounge_home_page.dart`)
**Integrated Endpoints:**
- `GET /api/v1/lounges` - List all lounges for owner

**Features:**
- Dynamic lounge list from API
- Empty state when no lounges exist
- Pull-to-refresh for lounge list
- Status badges (Active, Pending, Rejected)
- Lounge cards with details:
  - Name and location
  - Capacity and price per hour
  - Rating and reviews
  - Current status

## Files Created

### Models (`lib/models/`)
1. **lounge.dart** - Lounge data model
2. **booking.dart** - Booking and DashboardStats models
3. **product.dart** - Product and BusSchedule models

### Services (`lib/services/`)
1. **api_config.dart** - API configuration and response handling
2. **lounge_service.dart** - Lounge API calls
3. **dashboard_service.dart** - Dashboard and booking API calls
4. **product_service.dart** - Product and bus schedule API calls

## API Configuration

### Base URL (in `api_config.dart`):
```dart
static const String baseUrl = 'http://localhost:8080/api/v1';
```

**Important:** Change this based on your testing environment:
- **Android Emulator:** `http://10.0.2.2:8080/api/v1`
- **iOS Simulator:** `http://localhost:8080/api/v1`
- **Physical Device:** `http://YOUR_COMPUTER_IP:8080/api/v1`

## How to Test

### 1. Start the Backend Server
```powershell
cd c:\Users\user\AndroidStudioProjects\Bus_loung\backend
go run main.go
```

### 2. Update API Configuration
Open `lib/services/api_config.dart` and set the correct base URL for your device.

### 3. Run the Flutter App
```powershell
cd c:\Users\user\AndroidStudioProjects\Bus_loung\bus_lounge_app
flutter run
```

### 4. Test Features

**Dashboard:**
1. Navigate to Dashboard page
2. Check if stats load automatically
3. Pull down to refresh
4. Click refresh icon in app bar

**Lounge Home:**
1. Navigate to Lounge Home page (bottom nav bar - 2nd icon)
2. See "No Lounge Listed Yet" if no data
3. Click "List Your Lounge" to create one
4. After creating, lounges will appear in list
5. Pull to refresh the list
6. Click on a lounge card to view details

## API Services Available

### LoungeService
```dart
// Get all lounges
loungeService.getLounges(
  loungeOwnerId: 'owner-id',
  page: 1,
  perPage: 10,
  status: 'active', // optional
  city: 'Colombo',  // optional
)

// Create lounge
loungeService.createLounge(
  loungeOwnerId: 'owner-id',
  request: CreateLoungeRequest(...),
)

// Get lounge by ID
loungeService.getLoungeById('lounge-id')

// Update lounge
loungeService.updateLounge(
  loungeId: 'lounge-id',
  updates: {...},
)

// Delete lounge
loungeService.deleteLounge('lounge-id')
```

### DashboardService
```dart
// Get dashboard stats
dashboardService.getDashboardStats(
  loungeOwnerId: 'owner-id',
)
```

### BookingService
```dart
// Get bookings
bookingService.getBookings(
  loungeOwnerId: 'owner-id',
  loungeId: 'lounge-id', // optional
  status: 'confirmed',   // optional
)

// Get today's bookings
bookingService.getTodayBookings(
  loungeOwnerId: 'owner-id',
)

// Update booking status
bookingService.updateBookingStatus(
  bookingId: 'booking-id',
  status: 'confirmed',
)
```

### ProductService
```dart
// Get products
productService.getProducts(
  loungeId: 'lounge-id',
  category: 'food', // optional
)
```

### BusScheduleService
```dart
// Get today's bus schedules
busScheduleService.getTodaySchedules()
```

## Error Handling

All API calls include comprehensive error handling:

1. **Network Errors** - Shows "Network error" message
2. **API Errors** - Shows server error message
3. **Timeout** - 30 second timeout with error message
4. **No Data** - Shows empty state

## Next Steps to Complete Integration

### 1. Add Authentication
Currently using hardcoded lounge owner ID:
```dart
final String _loungeOwnerId = 'demo-owner-id';
```

**TODO:**
- Implement login/signup
- Store user ID in shared preferences
- Use actual user ID in API calls

### 2. Integrate Remaining Screens

**Booking Management** (`lounge_booking.dart`):
```dart
// Use BookingService to:
- Load bookings list
- Create new bookings
- Update booking status
- View booking details
```

**Marketplace** (`marketplace_screen.dart`):
```dart
// Use ProductService to:
- Load products
- Filter by category
- Add/edit products
```

**Bus Schedule** (`bus_schedule_screen.dart`):
```dart
// Use BusScheduleService to:
- Load today's schedules
- Filter by route/time
- View schedule details
```

### 3. Add Local State Management

Consider using Provider for global state:
```dart
// Create providers for:
- UserProvider (authentication state)
- LoungeProvider (lounge data)
- BookingProvider (booking data)
```

### 4. Add Offline Support

- Use `sqflite` for local database
- Cache API responses
- Sync when online

### 5. Add Real-time Updates

- Use WebSocket or polling
- Update dashboard stats automatically
- Show notifications for new bookings

## Testing with Postman

Before testing in Flutter, verify backend endpoints:

### Test Dashboard Stats:
```
GET http://localhost:8080/api/v1/dashboard/stats?lounge_owner_id=demo-owner-id
```

### Test Get Lounges:
```
GET http://localhost:8080/api/v1/lounges?lounge_owner_id=demo-owner-id
```

### Create Test Data:

1. **Create User** (in database):
```sql
INSERT INTO users (user_id, username, email, password_hash, role)
VALUES ('demo-owner-id', 'demo_owner', 'demo@example.com', 'hash123', 'lounge_owner');

INSERT INTO lounge_owners (owner_id, user_id, owner_name, business_name, phone_number)
VALUES (gen_random_uuid(), 'demo-owner-id', 'Demo Owner', 'Demo Business', '0771234567');
```

2. **Create Lounge**:
```
POST http://localhost:8080/api/v1/lounges?lounge_owner_id=demo-owner-id
{
  "lounge_name": "Test Lounge",
  "description": "Test lounge for demo",
  "address": "123 Test St",
  "city": "Colombo",
  "contact_number": "0771234567",
  "capacity": 50,
  "price_per_hour": 1000,
  "facilities": ["Wi-Fi", "A/C"],
  "opening_time": "08:00:00",
  "closing_time": "22:00:00"
}
```

## Troubleshooting

### Issue: "Network error" in Flutter

**Solutions:**
1. Check if backend server is running
2. Verify API base URL is correct for your device
3. Check if firewall is blocking connections
4. For physical device, ensure computer and phone are on same network

### Issue: "Failed to load" errors

**Solutions:**
1. Check backend logs for errors
2. Verify database is running and has data
3. Check API response format matches models
4. Ensure lounge_owner_id exists in database

### Issue: Empty data in Flutter

**Solutions:**
1. Create test data in database
2. Use correct lounge_owner_id
3. Check API returns data in Postman first

### Issue: Compile errors in Flutter

**Solutions:**
1. Run `flutter pub get` to install packages
2. Check all imports are correct
3. Restart IDE/editor

## Dependencies Added

```yaml
dependencies:
  http: ^1.1.0           # HTTP client
  provider: ^6.1.1       # State management
  flutter_dotenv: ^5.1.0 # Environment variables
```

## Summary

✅ **Completed:**
- API service layer created
- Data models defined
- Dashboard API integrated
- Lounge list API integrated
- Error handling implemented
- Loading states added
- Pull-to-refresh functionality

⏳ **Remaining:**
- Authentication implementation
- Remaining screen integrations
- Local storage
- Real-time updates
- Photo upload
- Complete CRUD operations for all entities

---

**Last Updated:** October 30, 2025
**Integration Status:** 40% Complete
**Next Priority:** Authentication + Booking Management Integration
