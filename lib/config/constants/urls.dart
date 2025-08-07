class AppUrls{
  static const String googleApiUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";


  static final String base = "https://backend.tasti.co.za";

  static final String login = "$base/restaurant/login";
  static final String signup = "$base/restaurant/signup";
  static final String logout = "$base/restaurant/logout";
  static final String forgotPassword = "$base/restaurant/forgot-password";
  static final String updateAdminPassword = "$base/restaurant/update-admin-password";
  static final String updateAdminProfile = "$base/restaurant/update-admin-profile";
  static final String adminDashboard = "$base/restaurant/get-admin-dashboard";
  static final String adminReservations = "$base/restaurant/get-admin-reservations";
  static final String fetchAdminSMS = "$base/restaurant/get-admin-sms";
  static final String adminAddSMS = "$base/restaurant/add-sms-bundle";
  static final String adminDeleteSmsBundle = "$base/restaurant/delete-sms-bundle";
  static final String fetchAdminTransactionHistory = "$base/restaurant/get-admin-transaction-history";
  static final String adminManageDiscount = "$base/restaurant/manage-discount";
  static final String adminFetchMonthlyFee = "$base/restaurant/get-fees";
  static final String adminUpdateMonthlyFee = "$base/restaurant/update-fees";
  static final String adminFetchTodayRequests = "$base/restaurant/get-today-requests";
  static final String adminFetchOverallRequests = "$base/restaurant/get-overall-requests";
  static final String adminFetchMonthRequests = "$base/restaurant/get-month-requests";
  static final String adminDeleteTodayRequests = "$base/restaurant/delete-request";
  static final String adminFetchTodayQueries = "$base/restaurant/get-today-queries";
  static final String adminFetchOverallQueries = "$base/restaurant/get-overall-queries";
  static final String adminFetchMonthQueries = "$base/restaurant/get-month-queries";
  static final String adminDeleteTodayQuery = "$base/restaurant/delete-request";
  static final String adminReplyTodayQuery = "$base/restaurant/send-query-reply";
  static final String deleteAdminProfile = "$base/restaurant/delete-admin-profile";
  static final String deleteRestaurantProfile = "$base/restaurant/delete-restaurant";
  static final String adminFetchCampaigns = "$base/restaurant/get-admin-campaigns";
  static final String adminFetchCampaignsByRes = "$base/restaurant/get-admin-campaigns-by-res";
  static final String adminApproveCampaign = "$base/restaurant/approve-campaign";
  static final String adminFetchEvents = "$base/restaurant/get-events";
  static final String adminDeleteEvent = "$base/restaurant/delete-event";
  static final String adminAddEvent = "$base/restaurant/add-event";
  static final String adminUpdateEvent = "$base/restaurant/update-event";
  static final String adminFetchAllRestaurants = "$base/restaurant/get-all-restaurants";
  static final String adminActivateRestaurant = "$base/restaurant/activate-restaurant";
  static final String adminSuspendRestaurant = "$base/restaurant/suspend-restaurant";
  
  static final String createRestaurant = "$base/restaurant/create-restaurant";
  static final String updateRestaurant = "$base/restaurant/update-restaurant";
  static final String getDashboard = "$base/restaurant/get-dashboard";
  static final String initializePayment = "$base/restaurant/initialize-payment";
  static final String verifyPayment = "$base/restaurant/verify-payment";
  static final String getVenues = "$base/restaurant/get-spots";
  static final String deleteVenues = "$base/restaurant/delete-spot";
  static final String addVenues = "$base/restaurant/update-spot";
  static final String deleteCuisine = "$base/restaurant/delete-type";
  static final String addCuisine = "$base/restaurant/update-type";
  static final String getCuisine = "$base/restaurant/get-types";
  static final String addGallery = "$base/restaurant/add-gallery";
  static final String fetchGalleries = "$base/restaurant/get-galleries";
  static final String deleteGallery = "$base/restaurant/delete-gallery";
}