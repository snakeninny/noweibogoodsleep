@interface SBApplication : NSObject
- (NSString *)bundleIdentifier;
@end

@interface SBAlertItem : NSObject <UIAlertViewDelegate>
- (void)dismiss;
- (UIAlertView *)alertSheet;
@end

@interface SBAlertItemsController : NSObject
+ (id)sharedInstance;
- (void)deactivateAlertItem:(SBAlertItem *)arg1;
- (void)activateAlertItem:(SBAlertItem *)arg1;
@end

@interface UIAlertView (Addition)
- (void)setBodyText:(id)arg1;
- (void)setNumberOfRows:(int)arg1;
- (void)dismiss;
- (void)setForceHorizontalButtonsLayout:(BOOL)arg1;
@end

@interface SBTelephonyManager : NSObject
+ (id)sharedTelephonyManager;
- (BOOL)isInAirplaneMode;
- (void)setIsInAirplaneMode:(BOOL)arg1;
@end
