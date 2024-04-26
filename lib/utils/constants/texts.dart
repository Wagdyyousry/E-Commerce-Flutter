
class MyTexts {
  MyTexts._();

// -- OnBoarding Texts
  static const String onBoardingTitle1 = "Choose your product";
  static const String onBoardingSubTitle1 =
      "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!";

  static const String onBoardingTitle2 = "Select Payment Method";
  static const String onBoardingSubTitle2 =
      "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!";

  static const String onBoardingTitle3 = "Deliver at your door step";
  static const String onBoardingSubTitle3 =
      "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!";

// -- Home
  static const String homeAppbarTitle = "Good Day For Shopping";
  static const String homeAppbarSubTitle = "User Name";

  // Authentication Form Text
  static const String name = "Name";
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "E-Mail";
  static const String password = "Password";
  static const String newPassword = "New Password";
  static const String username = "Username";
  static const String phoneNum = "Phone Number";
  static const String rememberMe = "Remember Me";
  static const String forgetPassword = "Forget Password?";
  static const String signIn = "Sign In";
  static const String createAccount = "Create Account";
  static const String orSignInwith = "or sign in with";
  static const String orSignupwith = "or sign up with";
  static const String iAgreeTo = "I agree to ";
  static const String privacyPolicy = "Privacy Policy";
  static const String termsofuse = "Terms of use";
  static const String verificationCode = "verificationCode";
  static const String resendEmail = "Resend Email";
  static const String resendEmailIn = "Resend email in";
  static const String contu = " Continue ";
  static const String and = " And ";
  static const String done = " Done ";
  static const String submit = " Submit ";
  static const String acceptPrivacy = "You have to accept Privacy Policy";
  static const String acceptPrivacyCon =
      "In Order to create an acount, you have to accept the privacy policy & terms of use";

  // Authentication Headings Text

  // -- Login Texts
  static const String loginTitle = "Welcome again my friend, ";
  static const String loginSubTitle =
      "Descover the new and limitless products with us.";
  static const String loginTitle2 = "Welcome back, ";
  static const String loginSubTitle2 =
      "Discover Limitless Choices and Unmatched Convenience.";
  static const String signupTitle = "Let's create your account";
  static const String forgetPasswordTitle = "Forget password";
  static const String forgetPasswordSubTitle =
      "Don't worry sometimes people can forget too, enter your email and we will send you a password reset Link.";
  static const String changeYourPasswordTitle = "Password Reset Email Sent";
  static const String changeYourPasswordSubTitle =
      "Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.";
  static const String confirmEmail = "Verify your email address!";
  static const String confirmEmailSubTitle =
      "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a world of Unrivaled Deals and Personalized Offers.";
  static const String emailNotReceivedMessage =
      "Didn't get the email? Check your junk/spam or resend it.";
  static const String yourAccountCreatedTitle =
      "Your account successfully created!";
  static const String yourAccountCreatedSubTitle =
      "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!";

  static const String reviewAndRatingText =
      "These Rating and Reviews are from other people's accounts that using the app";
  // -- Type of sign in
  static const google = "GoogleSignIn";
  static const emailAndPass = "EmailAndPassword";

  // -- Product Texts
  static const String title = " Title ";
  static const String discount = " Discount ";
  static const String discreption = " Discreption ";
  static const String price = " Price ";
  static const String quantity = " Quantity ";
  static const String addProduct = " Add Product ";

  static const List<String> categoriesNames = [
    "Men",
    "Women",
    "Babies",
    "Fruits",
    "Grocery",
    "Juice",
    "Flowers",
  ];
  static const List<String> productColors = [
    "red",
    "lightBlue",
    "blue",
    "darkBlue",
    "lightYellow",
    "yellow",
    "darkYellow",
    "black",
    "lightBrown",
    "brown",
    "darkBrown",
    "whit",
    "lightGreen",
    "green",
    "darkGreen",
    "lightGrey",
    "grey",
    "darkGrey",
    "lightOrange",
    "orange",
    "darkOrange",
    "lightPink",
    "pink",
    "darkPink",
    "lightPurple",
    "purple",
    "darkPurple",
  ];
  static List<String> productSizes() {
    List<String> listSizes =
        List<String>.generate(100, (index) => (index + 1).toString());
    listSizes.insertAll(0, ["Sm", "Md", "Lg", "Xl", "Xx", "Xxx"]);
    return listSizes;
  }

  static const String deleteAccountMessage =
      'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.';
}
