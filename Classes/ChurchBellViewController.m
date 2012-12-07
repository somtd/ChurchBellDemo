#import "ChurchBellViewController.h"

@implementation ChurchBellViewController
@synthesize debugView = _debugView;
@synthesize currentSound = _currentSound;
@synthesize lastSound = _lastSound;
@synthesize touchView = _touchView;

- (void)dealloc
{
    // サウンドを破棄する
    AudioServicesDisposeSystemSoundID(_soundC4);
    AudioServicesDisposeSystemSoundID(_soundCS);
    AudioServicesDisposeSystemSoundID(_soundD);
    AudioServicesDisposeSystemSoundID(_soundDS);
    AudioServicesDisposeSystemSoundID(_soundE);
    AudioServicesDisposeSystemSoundID(_soundF);
    AudioServicesDisposeSystemSoundID(_soundFS);
    AudioServicesDisposeSystemSoundID(_soundG);
    AudioServicesDisposeSystemSoundID(_soundGS);
    AudioServicesDisposeSystemSoundID(_soundA);
    AudioServicesDisposeSystemSoundID(_soundAS);
    AudioServicesDisposeSystemSoundID(_soundB);
    AudioServicesDisposeSystemSoundID(_soundC5);
    
    [super dealloc];
}

- (void)viewDidLoad
{
    //シリアル通信部分を初期化
    _rscMgr = [[RscMgr alloc] init];
    [_rscMgr setDelegate:self];
    
    //gestureを設定
    [self createGestureRecognizers];
    
    self.currentSound = @"100";
    self.lastSound = @"100";
    
    // サウンドを読み込む
    NSURL*  url;
        
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"C4" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundC4);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"C#" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundCS);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"D" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundD);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"D#" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundDS);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"E" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundE);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"F" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundF);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"F#" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundFS);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"G" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundG);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"G#" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundGS);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"A" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundA);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"A#" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundAS);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"B" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundB);
    url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"C5" ofType:@"aif"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &_soundC5);
    
}

- (void)createGestureRecognizers {
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.touchView addGestureRecognizer:singleTapRecognizer];
}

- (void)handleTap:(id)sender
{
    // タグを取得して、サウンドを決定する
    SystemSoundID   sound = (SystemSoundID)NULL;
    //switch ([sender tag]) {
    switch ([self.currentSound intValue]) {
        case 10: sound = _soundC4;  break;
        case 20: sound = _soundCS; break;
        case 30: sound = _soundD;  break;
        case 40: sound = _soundDS; break;
        case 50: sound = _soundE;  break;
        case 60: sound = _soundF;  break;
        case 70: sound = _soundFS; break;
        case 80: sound = _soundG;  break;
        case 90: sound = _soundGS; break;
        case 100: sound = _soundA;  break;
        case 110: sound = _soundAS; break;
        case 120: sound = _soundB;  break;
        case 130: sound = _soundC5; break;
    }
    // サウンドを鳴らす
    if (sound) {
        AudioServicesPlaySystemSound(sound);
    }
}
 
- (void)setTouchViewColor
{
    float ratio = [self.currentSound floatValue]/130.0;
    [UIView animateWithDuration:0.3f animations:^{
        self.touchView.backgroundColor = [UIColor colorWithRed:1.0 green:ratio blue:1.0-ratio alpha:1.0];
    } completion:^(BOOL finished) {
        self.debugView.text = @"animated";
        
    }];
}

#pragma mark - RscMgrDelegate methods

- (void) cableConnected:(NSString *)protocol
{
    [_rscMgr setBaud:9600];
    [_rscMgr open];
}

- (void) cableDisconnected
{
    
}

- (void) portStatusChanged
{
    
}

- (void) readBytesAvailable:(UInt32)numBytes
{
    int bytesRead = [_rscMgr read:rxBuffer Length:numBytes];
    NSLog(@"Read %d bytes from serial cable.", bytesRead);
    NSString *string = nil;
    for(int i = 0;i < numBytes;++i) {
        if ( string ) {
            string = [NSString stringWithFormat:@"%@%c", string, rxBuffer[i]];
        } else {
            string = [NSString stringWithFormat:@"%c", rxBuffer[i]];
        }
    }
    self.currentSound = string;
    self.debugView.text = [self.currentSound copy];
    
    if (![self.currentSound isEqualToString:self.lastSound])
    {
        [self setTouchViewColor];
        self.lastSound = [self.currentSound copy];
    }
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len
{
    return FALSE;
}

- (void) didReceivePortConfig
{
    
}

@end
