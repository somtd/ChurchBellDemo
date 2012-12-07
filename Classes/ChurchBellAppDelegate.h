#import <UIKit/UIKit.h>

@class ChurchBellViewController;

@interface ChurchBellAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow*                   window;
    ChurchBellViewController*   viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChurchBellViewController *viewController;

@end

