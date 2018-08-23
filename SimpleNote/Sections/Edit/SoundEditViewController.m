//
//  SoundEditViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "SoundEditViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundEditViewController ()
@property(nonatomic, strong)UIButton *soundButton;

@property(nonatomic ,strong) AVAudioRecorder *recorder;
@property(nonatomic, strong) AVAudioSession *session;

@end

@implementation SoundEditViewController
- (UIButton *)soundButton{
    if (!_soundButton) {
        _soundButton = [[UIButton alloc] init];
        _soundButton.frame = CGRectMake((MZWIDTH-100)/2.0, 230, 200,60);
        [_soundButton setTitle:@"start" forState:UIControlStateNormal];
        [_soundButton setTitle:@"stop" forState:UIControlStateSelected];
        
        [_soundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_soundButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _soundButton.backgroundColor = [UIColor whiteColor];
        [_soundButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchDown];
        [_soundButton addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _soundButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createRecord];
    [self.view addSubview:self.soundButton];
}

- (void)createRecord{

    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [session setActive:YES error:nil];
    }
    
    self.session = session;
    //1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   NSString * filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    NSURL * recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    self.recorder = [[AVAudioRecorder alloc] initWithURL:recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
    
}

- (void)startAction:(UIButton *)sender{
    
    [self.recorder record];
}
- (void)stopAction:(UIButton *)sender{

    [self.recorder stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
