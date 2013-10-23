#import "Tweak.h"

Class NWAlertView;

__attribute__((always_inline))
static inline void NWAlertView$alertSheet$buttonClicked$(id self, SEL sel, id arg1, int arg2)
{
	if (![[%c(SBTelephonyManager) sharedTelephonyManager] isInAirplaneMode])
		[[%c(SBTelephonyManager) sharedTelephonyManager] setIsInAirplaneMode:YES];
	[self dismiss];
}

/*
   __attribute__((always_inline))
   static inline void NWAlertView$alertView$clickedButtonAtIndex$(id self, SEL sel, id arg1, int arg2)
   {
   [self dismiss];
   }
 */

__attribute__((always_inline))
static inline void NWAlertView$configure$requirePasscodeForActions$(id self, SEL sel, BOOL arg1, BOOL arg2)
{
	UIAlertView *sheet = [self alertSheet];
	[sheet setDelegate:self];
	[sheet setBodyText:@"别玩啦！断网睡觉啦！"];
	[sheet addButtonWithTitle:@"好的"];
	[sheet setNumberOfRows:1];
}

__attribute__((always_inline))
static inline void NWAlertView$performUnlockAction(id self, SEL sel)
{
	[[%c(SBAlertItemsController) sharedInstance] activateAlertItem:self];
}

__attribute__((always_inline))
static inline void ShowNWAlertView(void)
{
	if (NWAlertView == nil)
		NWAlertView = objc_lookUpClass("NWAlertView");
	if (NWAlertView == nil)
	{
		NWAlertView = objc_allocateClassPair(objc_getClass("SBAlertItem"), "NWAlertView", 0);

		Method alertSheet$buttonClicked$ = class_getInstanceMethod(objc_getClass("SBAlertItem"), @selector(alertSheet:buttonClicked:));
		const char *types1 = method_getTypeEncoding(alertSheet$buttonClicked$);
		class_addMethod(NWAlertView, @selector(alertSheet:buttonClicked:), (IMP)&NWAlertView$alertSheet$buttonClicked$, types1);

		/*
		   Method alertView$clickedButtonAtIndex$ = class_getInstanceMethod(objc_getClass("SBAlertItem"), @selector(alertView:clickedButtonAtIndex:));
		   const char *types2 = method_getTypeEncoding(alertView$clickedButtonAtIndex$);
		   class_addMethod(NWAlertView, @selector(alertView:clickedButtonAtIndex:), (IMP)&NWAlertView$alertView$clickedButtonAtIndex$, types2);
		 */

		Method configure$requirePasscodeForActions$ = class_getInstanceMethod(objc_getClass("SBAlertItem"), @selector(configure:requirePasscodeForActions:));
		const char *types3 = method_getTypeEncoding(configure$requirePasscodeForActions$);
		class_addMethod(NWAlertView, @selector(configure:requirePasscodeForActions:), (IMP)&NWAlertView$configure$requirePasscodeForActions$, types3);

		Method performUnlockAction = class_getInstanceMethod(objc_getClass("SBAlertItem"), @selector(performUnlockAction));
		const char *types4 = method_getTypeEncoding(performUnlockAction);
		class_addMethod(NWAlertView, @selector(performUnlockAction), (IMP)&NWAlertView$performUnlockAction, types4);

		objc_registerClassPair(NWAlertView);
	}

	[[objc_getClass("SBAlertItemsController") sharedInstance] activateAlertItem:[[[NWAlertView alloc] init] autorelease]];
}

__attribute__((always_inline))
static inline BOOL IsTimeToSleep(void)
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
	NSInteger currentHour = [components hour];
	if (currentHour >= 0 && currentHour <= 6) return YES;
	return NO;
}

%hook SBUIController
- (void)activateApplicationFromSwitcher:(SBApplication *)arg1
{
	if ([[arg1 bundleIdentifier] isEqualToString:@"com.sina.weibo"] && IsTimeToSleep())
	{
		ShowNWAlertView();
		return;
	}
	%orig;
}

- (void)activateApplicationAnimated:(SBApplication *)arg1
{
	if ([[arg1 bundleIdentifier] isEqualToString:@"com.sina.weibo"] && IsTimeToSleep())
	{
		ShowNWAlertView();
		return;
	}
	%orig;
}
%end
