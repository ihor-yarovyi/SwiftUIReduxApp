// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {

  public enum Alert {
    public enum Actions {
      /// OK
      public static let ok = Strings.tr("Localizable", "alert.actions.ok")
      /// Settings
      public static let settings = Strings.tr("Localizable", "alert.actions.settings")
    }
    public enum Messages {
      /// Access to the %@ is denied
      public static func denied(_ p1: Any) -> String {
        return Strings.tr("Localizable", "alert.messages.denied", String(describing: p1))
      }
    }
    public enum Titles {
      /// Error
      public static let error = Strings.tr("Localizable", "alert.titles.error")
      /// Your password has been successfully changed
      public static let passwordChanged = Strings.tr("Localizable", "alert.titles.password_changed")
      /// Permission denied
      public static let permissionDenied = Strings.tr("Localizable", "alert.titles.permission_denied")
    }
  }

  public enum CompleteProfile {
    /// Complete Profile
    public static let title = Strings.tr("Localizable", "complete_profile.title")
    public enum Buttons {
      /// Create Account
      public static let createAccount = Strings.tr("Localizable", "complete_profile.buttons.create_account")
      /// Upload profile photo
      public static let uploadPhoto = Strings.tr("Localizable", "complete_profile.buttons.upload_photo")
    }
    public enum Inputs {
      public enum Bio {
        /// Bio (optional)
        public static let placeholder = Strings.tr("Localizable", "complete_profile.inputs.bio.placeholder")
      }
      public enum FirstName {
        /// First Name
        public static let placeholder = Strings.tr("Localizable", "complete_profile.inputs.first_name.placeholder")
      }
      public enum LastName {
        /// Last Name (optional)
        public static let placeholder = Strings.tr("Localizable", "complete_profile.inputs.last_name.placeholder")
      }
      public enum PhoneNumber {
        /// Phone number (optional)
        public static let placeholder = Strings.tr("Localizable", "complete_profile.inputs.phone_number.placeholder")
      }
    }
    public enum Sheet {
      /// Choose a source of the photo
      public static let title = Strings.tr("Localizable", "complete_profile.sheet.title")
    }
  }

  public enum EmailVerification {
    /// Verification Email
    public static let title = Strings.tr("Localizable", "email_verification.title")
    public enum Buttons {
      /// Resend
      public static let resend = Strings.tr("Localizable", "email_verification.buttons.resend")
      /// Sign In
      public static let signIn = Strings.tr("Localizable", "email_verification.buttons.sign_in")
    }
    public enum Labels {
      /// We sent a verification email to «%@». Click the link in the email to verify your email.
      public static func description(_ p1: Any) -> String {
        return Strings.tr("Localizable", "email_verification.labels.description", String(describing: p1))
      }
      /// Don’t have a link?
      public static let doNotHaveALink = Strings.tr("Localizable", "email_verification.labels.do_not_have_a_link")
      /// Please verify your email
      public static let title = Strings.tr("Localizable", "email_verification.labels.title")
    }
  }

  public enum EmailVerificationStatus {
    /// Verification Email
    public static let title = Strings.tr("Localizable", "email_verification_status.title")
    public enum Buttons {
      /// Sign In
      public static let signIn = Strings.tr("Localizable", "email_verification_status.buttons.sign_in")
    }
    public enum Labels {
      public enum Failed {
        /// Email has not been verified
        public static let description = Strings.tr("Localizable", "email_verification_status.labels.failed.description")
        /// Email not verified
        public static let title = Strings.tr("Localizable", "email_verification_status.labels.failed.title")
      }
      public enum Success {
        /// Email has been verified
        public static let description = Strings.tr("Localizable", "email_verification_status.labels.success.description")
        /// Email successfully verified
        public static let title = Strings.tr("Localizable", "email_verification_status.labels.success.title")
      }
    }
  }

  public enum ImageCroppingView {
    public enum Actions {
      /// Cancel
      public static let cancel = Strings.tr("Localizable", "image_cropping_view.actions.cancel")
      /// Crop
      public static let crop = Strings.tr("Localizable", "image_cropping_view.actions.crop")
    }
  }

  public enum RestorePassword {
    /// Restore Password
    public static let title = Strings.tr("Localizable", "restore_password.title")
    public enum Buttons {
      /// Resend
      public static let resend = Strings.tr("Localizable", "restore_password.buttons.resend")
      /// Sign In
      public static let signIn = Strings.tr("Localizable", "restore_password.buttons.sign_in")
    }
    public enum Inputs {
      /// Confirm New Password
      public static let confirmNewPassword = Strings.tr("Localizable", "restore_password.inputs.confirm_new_password")
      /// New Password
      public static let newPassword = Strings.tr("Localizable", "restore_password.inputs.new_password")
    }
    public enum Labels {
      /// Don't have a link?
      public static let dontHaveLink = Strings.tr("Localizable", "restore_password.labels.dont_have_link")
      /// Password Reset Email Sent
      public static let requestDidSend = Strings.tr("Localizable", "restore_password.labels.request_did_send")
      /// Restore link has been sent to
      /// «%@»
      public static func restoreLinkSentTo(_ p1: Any) -> String {
        return Strings.tr("Localizable", "restore_password.labels.restore_link_sent_to", String(describing: p1))
      }
    }
  }

  public enum Sheet {
    public enum Action {
      /// Take photo
      public static let camera = Strings.tr("Localizable", "sheet.action.camera")
      /// Choose from Gallery
      public static let gallery = Strings.tr("Localizable", "sheet.action.gallery")
    }
  }

  public enum SignIn {
    /// Login
    public static let title = Strings.tr("Localizable", "sign_in.title")
    public enum Buttons {
      public enum ForgotPassword {
        /// Forgot your password?
        public static let title = Strings.tr("Localizable", "sign_in.buttons.forgot_password.title")
      }
      public enum SignIn {
        /// Sign In
        public static let title = Strings.tr("Localizable", "sign_in.buttons.sign_in.title")
      }
      public enum SignUp {
        /// Sign Up
        public static let title = Strings.tr("Localizable", "sign_in.buttons.sign_up.title")
      }
    }
    public enum Inputs {
      public enum Email {
        /// Email or Username
        public static let placeholder = Strings.tr("Localizable", "sign_in.inputs.email.placeholder")
      }
      public enum Password {
        /// Password
        public static let placeholder = Strings.tr("Localizable", "sign_in.inputs.password.placeholder")
      }
    }
    public enum Labels {
      /// Don’t have an account?
      public static let doNotHaveAccount = Strings.tr("Localizable", "sign_in.labels.do_not_have_account")
    }
  }

  public enum SignUp {
    /// Sign Up
    public static let title = Strings.tr("Localizable", "sign_up.title")
    public enum Buttons {
      public enum LogIn {
        /// Log in
        public static let title = Strings.tr("Localizable", "sign_up.buttons.log_in.title")
      }
      public enum SignUp {
        /// Sign Up
        public static let title = Strings.tr("Localizable", "sign_up.buttons.sign_up.title")
      }
    }
    public enum Inputs {
      public enum ConfirmPassword {
        /// Confirm Password
        public static let placeholder = Strings.tr("Localizable", "sign_up.inputs.confirm_password.placeholder")
      }
      public enum Email {
        /// Email
        public static let placeholder = Strings.tr("Localizable", "sign_up.inputs.email.placeholder")
      }
      public enum Password {
        /// Password
        public static let placeholder = Strings.tr("Localizable", "sign_up.inputs.password.placeholder")
      }
      public enum Username {
        /// Username
        public static let placeholder = Strings.tr("Localizable", "sign_up.inputs.username.placeholder")
      }
    }
    public enum Labels {
      /// Already have an account?
      public static let alreadyHaveAnAccount = Strings.tr("Localizable", "sign_up.labels.already_have_an_account")
    }
    public enum Validation {
      /// Passwords
      public static let groupName = Strings.tr("Localizable", "sign_up.validation.group_name")
    }
  }

  public enum Validation {
    /// %@ has not valid format
    public static func hasNotValidFormat(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.hasNotValidFormat", String(describing: p1))
    }
    /// %@ must be from %d to %d symbols
    public static func mustBe(_ p1: Any, _ p2: Int, _ p3: Int) -> String {
      return Strings.tr("Localizable", "validation.mustBe", String(describing: p1), p2, p3)
    }
    /// %@ cannot contain spaces
    public static func noSpaces(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.noSpaces", String(describing: p1))
    }
    /// %@ don't match
    public static func notMatch(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.notMatch", String(describing: p1))
    }
    /// %@ is invalid
    public static func notValid(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.notValid", String(describing: p1))
    }
    /// %@ is required
    public static func `required`(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.required", String(describing: p1))
    }
    /// %@ should contain at least one letter and one digit and one capital letter
    public static func shouldContain(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.shouldContain", String(describing: p1))
    }
    /// %@ should not contain @ and spases
    public static func shouldNotContain(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.shouldNotContain", String(describing: p1))
    }
    /// %@ can't contain spaces only
    public static func spaceOnly(_ p1: Any) -> String {
      return Strings.tr("Localizable", "validation.spaceOnly", String(describing: p1))
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
