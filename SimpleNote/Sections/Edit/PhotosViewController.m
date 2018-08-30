//
//  PhotosViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 com. All rights reserved.
//

#import "PhotosViewController.h"
#import <ACSelectMediaView.h>

@interface PhotosViewController ()
{
    CGFloat mediaH;
    ACSelectMediaView *_mediaView;
}
@property(nonatomic, strong)UILabel *label;

@property(nonatomic, strong)NSArray<ACMediaModel *> *imageArr;

@property(nonatomic, strong)UIButton *saveButton;

@end

@implementation PhotosViewController

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = TextColor;
        _label.text = LocalizedString(@"pleaseChoose");
        [_label sizeToFit];
    }
    return _label;
}
- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.frame = CGRectMake(0, 0, 44,44);
        [_saveButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [_saveButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = LocalizedString(@"imgSet");
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    self.navigationItem.rightBarButtonItem = set;
    
    [self.view addSubview:self.label];
    if (!_mediaView) {
        ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label.frame)+15, [[UIScreen mainScreen] bounds].size.width, 1)];
        mediaView.type = ACMediaTypePhotoAndCamera;
        mediaView.maxImageSelected = 12;
        mediaView.naviBarBgColor = [UIColor whiteColor];
        mediaView.rowImageCount = 3;
        mediaView.lineSpacing = 20;
        mediaView.interitemSpacing = 20;
        mediaView.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        [mediaView observeViewHeight:^(CGFloat mediaHeight) {
            mediaH = mediaHeight;
           
        }];
        
        [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
            self.imageArr = [list mutableCopy];
        }];
        
        _mediaView = mediaView;
    }
    
    [self.view addSubview:_mediaView];
}

- (void)saveAction{
    NSLog(@"完成");
        
    [self.navigationController popViewControllerAnimated:YES];
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
