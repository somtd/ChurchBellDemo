#import "ChurchBellAppDelegate.h"
#import "ChurchBellViewController.h"

@implementation ChurchBellAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // ステータスバーを上にする
    [UIApplication sharedApplication].statusBarOrientation = UIInterfaceOrientationLandscapeRight;

    // アプリケーションの表示フレームを取得する
    CGRect  frame;
    frame = [UIScreen mainScreen].applicationFrame;
    
    // 中心位置を作成
    CGPoint center;
    center.x = CGRectGetWidth(frame) * 0.5f;
    center.y = CGRectGetHeight(frame) * 0.5f;
    
    // バウンズを作成
    CGRect  bounds;
    bounds.origin = CGPointZero;
    bounds.size.width = CGRectGetHeight(frame);
    bounds.size.height = CGRectGetWidth(frame);
    
    // アフィン変換を作成
    CGAffineTransform   transform;
    transform = CGAffineTransformMakeRotation(M_PI_2);
    
    // ビューを回転させる
    viewController.view.center = center;
    viewController.view.bounds = bounds;
    viewController.view.transform = transform;
	
    // ウィンドウを表示する
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [viewController release];
    [window release];
    
    [super dealloc];
}

@end
