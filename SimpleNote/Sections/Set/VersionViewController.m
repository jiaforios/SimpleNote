//
//  VersionViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/28.
//  Copyright © 2018年 com. All rights reserved.
//

#import "VersionViewController.h"

@interface VersionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation VersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = LocalizedString(@"versionInfo");
    self.appLabel.font = [UIFont systemFontOfSize:15];
    self.versionLabel.font = [UIFont systemFontOfSize:13];
    self.versionLabel.text = [NSString stringWithFormat:@"%@(%@)",AppVersion,AppBuildVersion];
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
