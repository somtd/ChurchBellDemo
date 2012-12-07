#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "RscMgr.h"

#define BUFFER_LEN 1024

@interface ChurchBellViewController : UIViewController <RscMgrDelegate>
{
    RscMgr *_rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    NSString *_lastSound;
    NSString *_currentSound;
    
    SystemSoundID   _soundC4;
    SystemSoundID   _soundCS;
    SystemSoundID   _soundD;
    SystemSoundID   _soundDS;
    SystemSoundID   _soundE;
    SystemSoundID   _soundF;
    SystemSoundID   _soundFS;
    SystemSoundID   _soundG;
    SystemSoundID   _soundGS;
    SystemSoundID   _soundA;
    SystemSoundID   _soundAS;
    SystemSoundID   _soundB;
    SystemSoundID   _soundC5;
    
    UIView *_touchView;
    UITextView *_debugView;
}
@property (nonatomic, strong) IBOutlet UITextView *debugView;
@property (nonatomic, strong) IBOutlet UIView *touchView;
@property (nonatomic, strong) NSString *currentSound;
@property (nonatomic, strong) NSString *lastSound;

@end

