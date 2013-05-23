#import "HBACViewController.h"

UIWindow *addWindow;
UIWindow *previousKeyWindow;
HBACViewController *sharedInstance;

@interface HBACViewController ()
- (void)dismiss;
@end

@implementation HBACViewController
+ (void)eventTriggered {
	if (sharedInstance) {
		return;
	}

	sharedInstance = [[self alloc] init];

	addWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	addWindow.windowLevel = UIWindowLevelStatusBar + 1.f;

	previousKeyWindow = [UIWindow.keyWindow retain];
	[addWindow addSubview:sharedInstance.view];
	[addWindow makeKeyAndVisible];
}

- (void)loadView {
	[super loadView];

	ABNewPersonViewController *newPersonViewController = [[[ABNewPersonViewController alloc] init] autorelease];
	newPersonViewController.newPersonViewDelegate = self;

	navigationController = [[UINavigationController alloc] initWithRootViewController:newPersonViewController];
	navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self presentViewController:navigationController animated:YES completion:NULL];
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person {
	[self dismiss]; //The instance one, not the class one. Long story.
}

- (void)dismiss {
	[sharedInstance dismissViewControllerAnimated:YES completion:^{
		[sharedInstance performSelector:@selector(_dismissCompleted) withObject:nil afterDelay:0.35f];
	}];
}

+ (void)dismiss {
	if (!sharedInstance) {
		return;
	}

	[sharedInstance dismiss]; //Back in my day, we could call our own class methods from instance methods...
}

- (void)_dismissCompleted {
	[previousKeyWindow makeKeyWindow];
	[previousKeyWindow release];
	previousKeyWindow = nil;

	[addWindow release];
	addWindow = nil;

	[sharedInstance release];
	sharedInstance = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(BOOL)interfaceOrientation {
	return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ? YES : interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)dealloc {
	[navigationController release];
	[super dealloc];
}
@end
