class AppRoutes {
  // ✅ Auth Routes
  static const String splash = '/splash';
  static const String login = '/login';
  // static const String signup = '/signup';
  static const String onboarding = '/onboarding';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = 'changePassword';

  // static const String notifications = '/notifications';

  // ✅ Profile / Info
  static const String profile = '/personal-info';

  // ✅ Main Layout (After Login)
  static const String skaleton = '/skaleton';

  // ✅ Restaurant-Specific Routes
  static const String makeReservation = '/make-reservation';
  static const String manageBookingTime = '/manage-booking-time';
  static const String updateTimeDuration = '/update-time-duration';
  static const String timeSlotManagement = '/time-slot-management';
  static const String inactiveTimeSlots = '/inactive-time-slots';
  static const String settingAreaDetails = '/setting-area-details';
  static const String addRestaurantUser = '/add-restaurant-user';
  static const String addAdminUser = '/add-admin-user';
  static const String customerReservationDetails =
      '/customer-reservation-details';
  static const String restaurantQRFoodMenu = '/restaurant-qr-food-menu';
  static const String targetedCampaign = '/targeted-campaign';
  static const String campaignSummary = '/campaign-summary';
  static const String addPhotos = '/add-photos';
  static const String contactUs = '/contact-us';
  static const String workingHours = '/working-hours';
  static const String seatingArea = '/seating-area';
  static const String addCuisines = '/add-cuisines';
  static const String foodMenu = '/food-menu';
  static const String gallery = '/gallery';
  static const String reservationDatabase = '/reservation-database';
  static const String maintainReviews = '/maintain-reviews';
  static const String createNewRestaurant = '/create-new-restaurant';

  // ✅ Common/Admin Routes
  static const String stats = '/stats';
  static const String reservations = '/reservations';
  static const String billings = '/billings';
  // static const String settings = '/settings';
  static const String setVanueCategory = '/settings/set-vanue-category';
  static const String share = '/share';
  static const String campaignDetailsByRes = '/campaign-details';
  static const String campaignByRes = '/campaign-by-res';
  static const String requestDetails = '/request-details';
  static const String queryDetails = '/query-details';
  static const String restaurantDetails = '/restaurant-details';
  static const String reservationDbDetails = '/reservation-db-details';
  static const String smsBundleDetails = '/sms-bundle-details';
  static const String manageSmsBundleDiscount = '/manage-sms-bundle-discount';
  static const String transactionHistory = '/transaction-history';
  static const String addSmsBundle = '/add-sms-bundle';
  static const String monthlyFee = '/monthly-fee';
  static const String updateMonthlyFee = '/update-monthly-fee';
  static const String addEvent = '/add-event';
  static const String updateEvent = '/update-event';
  static const String updateRestaurant = '/update-restaurant';
  static const String updateWorkingHours = '/update-working-hours';
  static const String addSeatingArea = '/add-seating-area';
  static const String restaurantTransactionHistory = '/restaurant-transaction-history';
  static const String buySmsBundles = '/buy-sms-bundles';
  static const String campaigns = '/campaigns';
  static const String campaignDetails = '/campaigns-details';
  static const String reservationDetails = '/reservation-details';
  static const String importDatabase = '/import-database';
  static const String csvImportedData = '/csv-imported-data';
  static const String reservationsByEmail = '/reservations-by-email';
  static const String csvSentCampaign = '/csv-sent-campaign';
  static const String sentCampaign = '/sent-campaign';
  static const String faqChat = 'faqChat';
}
