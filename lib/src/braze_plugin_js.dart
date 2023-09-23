@JS()
library braze;

import 'package:js/js.dart';

@JS('JSON.parse')
external Object jsonParse(String obj);

@JS('braze')
class BrazePluginJS {
  /// Initializes this braze instance with your API key. This method must be called before other Braze methods are invoked,
  /// and is part of the default loading snippets. Subsequent calls will be ignored until 'destroy` is called.
  external static initialize(String apiKey, InitializationOptions? options);

  /// Automatically display in-app messages when they are triggered.
  /// This method should be called before calling openSession.
  external static automaticallyShowInAppMessages();

  /// When a user first uses Braze on a device they are considered "anonymous". Use this method to identify
  /// a user with a unique ID, which enables the following:
  ///
  /// - If the same user is identified on another device, their user profile, usage history and event history will be shared across devices.
  /// - If your app is used on the same browser by multiple people, you can assign each of them a unique identifier to track them separately.
  ///   Only the most recent user on a particular browser will receive push notifications and in-app messages.
  external static changeUser(String userId, String? signature);

  /// The user currently being tracked by Braze, used for querying the tracked user id and setting user attributes.
  /// Should only be accessed via the getUser function.
  /// Returns null if the SDK has not been initialized.
  external static User getUser();

  /// Reports that the current user performed a custom named event.
  ///
  /// This function can be used to track any custom event that you want, such as a button click, a page view, or a purchase. To track an event, you must provide the event name and an optional object of event properties.
  ///
  /// The event name must be a string that is no longer than 255 characters in length and cannot begin with a dollar sign ($). The event properties object can contain any number of key-value pairs, where the keys are strings and the values can be any of the following types:
  ///
  /// * Numeric
  /// * Boolean
  /// * Date object
  /// * String (no longer than 255 characters in length)
  /// * Nested object (whose values can be numeric, boolean, Date objects, arrays, strings, or null)
  ///
  /// The total size of the event properties object cannot exceed 50KB.
  ///
  /// Parameters:
  ///
  /// * eventName: The identifier for the event to track.
  /// * eventProperties: An optional object of event properties.
  ///
  /// Returns: Void
  external static logCustomEvent(
      String eventName,
      Object? eventProperties,
      );

  /// Opens a new session, or resumes the previous session if this browser had activity within the sessionTimeoutInSeconds value.
  /// When a new session is opened, this refreshes In-App Messages.
  /// Content Cards are refreshed automatically if the subscribeToContentCardsUpdates has been registered prior to openSession.
  /// If the user has previously granted the site permission to send push, automatically sends the push registration to the Braze backend.
  ///
  /// Be sure to call openSession at the end of your initialization code section, after any calls to
  /// changeUser or subscribing to Content Cards, In-App Message, and Feature Flag updates.
  /// Calling openSession before changeUser may result in a second session start event.
  external static openSession();

  /// By default, data logged to Braze through the SDK is queued locally (in HTML 5 localStorage when available,
  /// and in memory otherwise) and sent to Braze's servers asynchronously on a regular interval (10 seconds when
  /// localStorage is available and not routinely cleared due to browser privacy features, otherwise 3 seconds).
  /// This is done to optimize network usage and provide resiliency against network or server outages.
  /// This method bypasses the interval and immediately flushes queued data.
  external static requestImmediateDataFlush();

  /// Subscribe to content cards updates. The subscriber callback will be called whenever content cards are updated.
  /// This method should be called before calling openSession.
  external static void subscribeToContentCardsUpdates(Function(ContentCards cards) callback);

  /// Requests an immediate refresh of content cards from Braze servers.
  /// By default, content cards are refreshed when a new session opens (see 'openSession` for more details),
  ///
  /// and when the user refreshes content cards manually via the refresh button.
  /// If you want to refresh content cards from the server at another time you must call this function.
  external static void requestContentCardsRefresh(Function? successCallBack, Function? errorCallBack);
}

@JS()
@anonymous
class Extras {
  /// Screen location key
  external String? get location;

  external factory Extras({String? location});
}

@JS()
class ContentCards {
  /// Array of Card descendents (ClassicCard, CaptionedImage, Banner).
  external List<Card> get cards;

  /// When this collection of cards was received from Braze servers.
  /// If null, it means the content cards are still being fetched for this user.
  external DateTime? get lastUpdated;
}

/// Abstract base for news feed and Content Cards cards. Use subclasses ClassicCard, CaptionedImage, ImageOnly, and ControlCard.
@JS('Card')
abstract class Card {
  /// When this card expires and should stop being shown to users.
  external get expiresAt;

  /// Object of string/string key/value pairs. Default to empty object {}.
  external Extras extras;

  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  external String? get id;

  /// Whether to pin this card to the top of the view.
  external bool get pinned;

  /// When this card is last modified.
  external get updated;

  /// Whether this card has been shown to the user.
  external bool get viewed;

  /// Remove all event subscriptions from this message.
  external void removeAllSubscriptions();
}

@JS('ClassicCard')
class ClassicCard extends Card {
  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  external String? get id;

  ///  Whether this card has been shown to the user.
  external bool get viewed;

  /// The title text for this card.
  external String? get title;

  /// The url for this card's image.
  external String? get imageUrl;

  /// The body text for this card
  external String? get description;

  /// When this card was created.
  external DateTime? get created;

  /// When this card was last modified.
  external DateTime? get updated;

  /// Object of string/string key/value pairs. Default to empty object {}.
  external Extras extras;

  /// The aspect ratio for this card's image. This field is meant to serve as a hint before image loading completes.
  /// Note that the field may not be supplied in certain circumstances.
  external int? get aspectRatio;
}

/// Provides further customization for initializing the [BrazeClient]
@JS()
@anonymous
class InitializationOptions {
  external bool? get allowCrawlerActivity;

  external set allowCrawlerActivity(bool? v);

  external bool? get allowUserSuppliedJavascript;

  external set allowUserSuppliedJavascript(bool? v);

  external String? get appVersion;

  external set appVersion(String? v);

  external String get baseUrl;

  external set baseUrl(String v);

  external String? get contentSecurityNonce;

  external set contentSecurityNonce(String? v);

  external bool? get disablePushTokenMaintenance;

  external set disablePushTokenMaintenance(bool? v);

  external bool? get doNotLoadFontAwesome;

  external set doNotLoadFontAwesome(bool? v);

  external bool? get enableLogging;

  external set enableLogging(bool? v);

  external List<String>? get devicePropertyAllowlist;

  external set devicePropertyAllowlist(List<String>? v);

  external bool? get enableSdkAuthentication;

  external set enableSdkAuthentication(bool? v);

  external int? get inAppMessageZIndex;

  external set inAppMessageZIndex(int? v);

  external String? get localization;

  external set localization(String? v);

  external bool? get manageServiceWorkerExternally;

  external set manageServiceWorkerExternally(bool? v);

  external int? get minimumIntervalBetweenTriggerActionsInSeconds;

  external set minimumIntervalBetweenTriggerActionsInSeconds(int? v);

  external bool? get noCookies;

  external set noCookies(bool? v);

  external bool? get openCardsInNewTab;

  external set openCardsInNewTab(bool? v);

  external bool? get openInAppMessagesInNewTab;

  external set openInAppMessagesInNewTab(bool? v);

  external bool? get requireExplicitInAppMessageDismissal;

  external set requireExplicitInAppMessageDismissal(bool? v);

  external String? get safariWebsitePushId;

  external set safariWebsitePushId(String? v);

  external String? get serviceWorkerLocation;

  external set serviceWorkerLocation(String? v);

  external int? get sessionTimeoutInSeconds;

  external set sessionTimeoutInSeconds(int? v);

  external factory InitializationOptions({
    bool? allowCrawlerActivity,
    bool? allowUserSuppliedJavascript,
    String? appVersion,
    String baseUrl,
    String? contentSecurityNonce,
    bool? disablePushTokenMaintenance,
    bool? doNotLoadFontAwesome,
    bool? enableLogging,
    List<String>? devicePropertyAllowlist,
    bool? enableSdkAuthentication,
    int? inAppMessageZIndex,
    String? localization,
    bool? manageServiceWorkerExternally,
    int? minimumIntervalBetweenTriggerActionsInSeconds,
    bool? noCookies,
    bool? openCardsInNewTab,
    bool? openInAppMessagesInNewTab,
    bool? requireExplicitInAppMessageDismissal,
    String? safariWebsitePushId,
    String? serviceWorkerLocation,
    int? sessionTimeoutInSeconds,
  });
}

@JS()
@anonymous
class User {
  external setCountry(String? country);

  external setCustomUserAttribute(String key, dynamic value, bool? merge);
}