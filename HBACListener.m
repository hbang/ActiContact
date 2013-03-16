#import "HBACListener.h"
#import "HBACViewController.h"

static BOOL visible = NO;

@implementation HBACListener
+(void)load {
	if (![[LAActivator sharedInstance] hasSeenListenerWithName:@"ws.hbang.acticontact"]) {
		[[LAActivator sharedInstance] assignEvent:[LAEvent eventWithName:@"libactivator.menu.press.triple"] toListenerWithName:@"ws.hbang.acticontact"];
	}

	[[LAActivator sharedInstance] registerListener:[self new] forName:@"ws.hbang.acticontact"];
}

-(void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
	if (visible) {
		[self activator:activator abortEvent:event];
		return;
	}

	[event setHandled:YES];

	visible = YES;

	[HBACViewController eventTriggered];
}

-(void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {
	if (visible) {
		visible = NO;
		[HBACViewController dismiss];
	}
}
@end
