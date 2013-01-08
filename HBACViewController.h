#import <AddressBookUI/AddressBookUI.h>

@interface HBACViewController : UIViewController <ABNewPersonViewControllerDelegate> {
	UINavigationController *navigationController;
}

+(void)eventTriggered;
+(void)dismiss;
@end

@interface UIApplication (Private)
-(UIInterfaceOrientation)activeInterfaceOrientation;
@end

@interface UIWindow (Private)
+(UIWindow *)keyWindow;
@end
