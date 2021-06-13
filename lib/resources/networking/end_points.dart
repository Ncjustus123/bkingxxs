class EndPoints {
  static const String getToken = "api/Token";
  static const String getProfile = "api/Account/getProfile";
  static const String getTerminals = "api/Terminal/Get";
  static const String getDestinationTerminal =
      "api/Route/GetDestinationTerminals/";
  static const String searchBuses = "api/Booking/Search";
  static const String postHireBus = "api/HireRequest/Add";
  static const String getBookingDetails = "api/Booking/Details/";
  static const String postAgentRequest = "api/Agents/AddApplicant";
  static const String signUpCustomer = "api/Customer/Add";
  static const String postBooking = "api/Booking/PostBooking";
  static const String activateAccount =  "api/Account/Activate/";
  static const String payStackPayment = "api/Booking/ProcessPaystackPayment";

  // @GET("api/Terminal/Get")
  // Call<DepartureTerminalResponse> getAllTerminals();

  // @GET("api/Route/GetDestinationTerminals/{departureTerminalId}")
  // Call<DestinationTerminalResponse> getDestinationTerminals(
  //     @Path("departureTerminalId") int departureTerminalId);

  // @POST("api/Booking/Search")
  // Call<BusSearchResponse> searchForBuses(
  //     @Body BusSearchRequest busSearchRequest);

  // @POST("api/Token")
  // Call<TokenResponse> postToken(@Body TokenRequest tokenRequest);

  // @POST("api/Customer/Add")
  // Call<SignUpResponse> postSignUp(@Body SignUpRequest signUpRequest);

  // @POST("api/Booking/PostBooking")
  // Call<BookingResponse> postBooking(@Body BookingRequest bookingRequest);

  // @POST("transaction/initialize")
  // Call<InitializeResponse> getAccessCode(@Body InitializeRequest body);

  // @GET("transaction/verify/{reference_code}")
  // Call<VerificationResponse> verifyTransaction(
  //     @Path("reference_code") String reference_code);

  // //paystack
  // @POST("api/Booking/ProcessPaystackPayment")
  // Call<ProcessPaymentResponse> processPayment(@Body ProcessPaymentRequest body);

  // //flutterwave
  // @POST("api/Booking/ProcessFlutterwavePayment")
  // Call<ProcessPaymentResponse> processFlutterwavePayment(
  //     @Body FlutterwaveVerifyObject body);

  // @POST("api/HireRequest/Add")
  // Call<BusHireResponse> postHireRequest(@Body BusHireRequest body);
  // @POST("api/Account/UpdateProfile")
  // Call<OtpResponse> postProfileUpdateRequest(@Body ProfileObject body);

  // @GET("api/Booking/Details/{refCode}")
  // Call<BookingDetailsResponse> getBookingDetails(
  //     @Path("refCode") String refCode);

  // @GET("api/Booking/ValidateCoupon")
  // Call<CouponCheckResponse> checkCoupon(@Query("couponCode") String coupon);

  // @GET("api/Account/getProfile")
  // @Headers("Cache-control: no-cache")
  // Call<ProfileResponse> getProfile();

  // @POST("api/Account/ForgotPassword/{userNameOrEmail}")
  // Call<OtpResponse> forgotPassword(@Path("userNameOrEmail") String userName);

  // @POST("api/Account/ResetPassword")
  // Call<OtpResponse> resetPassword(
  //     @Body ResetPasswordRequest resetPasswordRequest);

  // @POST("api/Account/ChangePassword")
  // Call<ProfileResponse> changePassword(
  //     @Body ChangePasswordRequest resetPasswordRequest);

  // @POST(" api/Account/Activate")
  // Call<SignUpResponse> activateAccount(
  //     @Query("userNameOrEmail") String userName,
  //     @Query("activationCode") String activationCode);

  // @POST("/api/Customer/SendActivationCode")
  // Call<OtpResponse> sendCode(@Query("userNameOrEmail") String userName);

  // @POST("/api/Customer/SendActivationCode")
  // Call<TokenResponse> sendCode1(@Query("userNameOrEmail") String userName);

  // @GET(" api/Booking/GetTripHistory/{phoneNo}")
  // Call<TripHistoryResponse> getTripHistory(@Path("phoneNo") String phoneNo);

  // @POST("api/Feedback/AddComplaint")
  // Call<ComplaintResponse> postComplaint(
  //     @Body ComplaintRequest complaintRequest);

  // @GET("api/passportType/Get")
  // Call<PassportTypeResponseObject> getPassportTypes();

  // @GET("api/Booking/GetEmployeeCouponCount")
  // Call<StaffBonusResponse> getStaffCoupons(
  //     @Query("phoneNumber") String phoneNumber);

  // @GET("api/Booking/GetCouponsByPhone")
  // Call<CouponListResponse> getUserCoupons(@Query("phone") String phoneNumber);

  // @POST("api/AgentToken/RefreshToken")
  // Call<TokenResponse> refreshToken(
  //     @Body RefreshTokenRequest refreshTokenRequest);

  // @POST("api/Agents/AddApplicant")
  // Call<AgentApplicationResponse> postAgentApplication(
  //     @Body AgentApplicationRequest request);
}
