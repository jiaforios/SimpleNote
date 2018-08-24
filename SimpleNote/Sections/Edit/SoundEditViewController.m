//
//  SoundEditViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/23.
//  Copyright © 2018年 com. All rights reserved.
//

#import "SoundEditViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZJFileManger.h"
#import "NoteModel.h"


@interface SoundEditViewController ()
@property(nonatomic, strong)UIButton *soundButton;

@property(nonatomic ,strong) AVAudioRecorder *recorder;
@property(nonatomic, strong) AVAudioSession *session;
@property(nonatomic, copy) NSString *soundPath;
@property(nonatomic, copy) NSDictionary *recordSetting;
@property(nonatomic, strong) NSURL *recordFileUrl;
@property(nonatomic, strong) AVAudioPlayer* player;

@end

@implementation SoundEditViewController

- (NSDictionary*)recordSetting{
    if (_recordSetting == nil) {
        _recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
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
    }
    return _recordSetting;
}

- (NSString *)soundPath{
    return [[Utils currentDateStrForSoundPathName] stringByAppendingString:@".wav"];
}
- (NSURL*)recordFileUrl{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"path =  %@",path);
    NSString * filePath = [ZJFileManger createDirectoryPath:[path stringByAppendingPathComponent:@"noteSound"]];
    filePath = [filePath stringByAppendingPathComponent:self.soundPath];
    NSURL * fileUrl = [NSURL fileURLWithPath:filePath];
    return fileUrl;
}

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

- (void)startSession{
    AVAudioSession *session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (session == nil) {
        NSLog(@"Error creating session: %@",[sessionError description]);
    }else{
        [session setActive:YES error:nil];
    }
    self.session = session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startSession];
    
    [self.view addSubview:self.soundButton];
}

- (void)createRecord{

    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:self.recordSetting error:nil];
    if (_recorder) {
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

- (void)startAction:(UIButton *)sender{
    NSLog(@"开始录音");
    [self createRecord];
    [self.recorder record];
}
- (void)stopAction:(UIButton *)sender{
    [self.recorder stop];
    NSLog(@"结束录音");

    NoteModel *model = [NoteModel new];
    model.soundUrl = self.soundPath;
    model.noteType = SoundNoteType;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        model.soundTime = [self audioSoundDuration:self.recordFileUrl];
        [model save];

    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"播放%@",self.recordFileUrl);
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
        NSError *sessionError;

        [self.session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
        if (sessionError != nil) {
            NSLog(@"Error play session: %@",[sessionError description]);
        }
        [self.player play];
        
    });
}

-(float)audioSoundDuration:(NSURL *)fileUrl{

    AVURLAsset *aset = [AVURLAsset URLAssetWithURL:fileUrl options:nil];
    CMTime duration = aset.duration;
    float seconds = CMTimeGetSeconds(duration);
    NSLog(@"model.time = %f",seconds);
    return seconds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
