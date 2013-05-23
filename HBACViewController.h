#import <AddressBookUI/AddressBookUI.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIWindow+Private.h>

@interface HBACViewController : UIViewController <ABNewPersonViewControllerDelegate> {
	UINavigationController *navigationController;
}

+ (void)eventTriggered;
+ (void)dismiss;
@end
