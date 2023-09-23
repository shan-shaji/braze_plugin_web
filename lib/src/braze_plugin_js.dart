@JS()
library braze;

import 'package:js/js.dart';

@JS('JSON.parse')
external Object jsonParse(String obj);

@JS("braze")
class BrazePluginJS {
  external static initialize(String apiKey, InitializationOptions? options);

  external static automaticallyShowInAppMessages();

  external static changeUser(String userId, String? signature);

  external static User getUser();

  external static logCustomEvent(
    String eventName,
    Object? eventProperties,
  );

  external static openSession();

  external static requestImmediateDataFlush();

  /// Subscribe to content cards updates. The subscriber callback will be called whenever content cards are updated.
  /// This method should be called before calling openSession.
  external static void subscribeToContentCardsUpdates(Function(ContentCards cards) callback);
}

@JS()
class ContentCards {
  /// Array of Card descendents (ClassicCard, CaptionedImage, Banner).
  external List<Card> get cards;

  /// When this collection of cards was received from Braze servers.
  /// If null, it means the content cards are still being fetched for this user.
  external get lastUpdated;

  /// Get the current unviewed card count. This is useful for powering badges on your control for showing the content cards.
  /// ControlCard cards do not count towards the unviewed count.
  external num getUnviewedCardCount();
}

/// Abstract base for news feed and Content Cards cards. Use subclasses ClassicCard, CaptionedImage, ImageOnly, and ControlCard.
@JS()
class Card {
  /// When this card expires and should stop being shown to users.
  external get expiresAt;

  /// Object of string/string key/value pairs. Default to empty object {}.
  @anonymous
  external get extras;

  /// Id of the card. This will be reported back to braze with events for analytics purposes.
  external String? get id;

  /// Whether to pin this card to the top of the view.
  external bool get pinned;

  /// When this card is last modified.
  external get updated;

  /// Whether this card has been shown to the user.
  external bool get viewed;

  /// Call this method if you wish to programmatically remove the card from the feed and log a dismissal.
  /// This method is meant to be used with the Braze UI.
  ///
  /// If you are using your own UI, this method will have no effect. Instead, you should use logCardDismissal
  /// to log analytics and then remove the card from the DOM manually.
  external void dismissCard();

  /// Remove all event subscriptions from this message.
  external void removeAllSubscriptions();
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
