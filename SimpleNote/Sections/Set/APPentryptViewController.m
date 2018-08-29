//
//  APPentryptViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//


#import "APPentryptViewController.h"
#import "OptionView.h"

@interface APPentryptViewController ()

@property(nonatomic, strong)OptionView *optView1;
@property(nonatomic, strong)OptionView *optView2;
@property(nonatomic, strong)UIButton *saveButton;
@property(nonatomic, strong)UIButton *stopButton;


@end

@implementation APPentryptViewController


- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.optView2.frame)+25, MZWIDTH-60, 44)];
        _saveButton.layer.cornerRadius = 10;
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_saveButton setTitleColor:AppColor forState:UIControlStateNormal];
        _saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [_saveButton setTitle:LocalizedString(@"saveOver") forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (OptionView *)optView1{
    if (!_optView1) {
        _optView1 = [[OptionView alloc] initWithFrame:CGRectMake(20, 60, MZWIDTH-40, 60) title:LocalizedString(@"fingureEncrypt") type:OptionViewTypeFingure];
    }
    return _optView1;
}

- (OptionView *)optView2{
    if (!_optView2) {
        _optView2 = [[OptionView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.optView1.frame)+20, MZWIDTH-40, 60) title:LocalizedString(@"pwdEncrypt") type:OptionViewTypePwd];
    }
    return _optView2;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"应用加密";

    [self.view addSubview:self.optView1];
    [self.view addSubview:self.optView2];
    
    [self.optView1 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt1"];
    [self.optView2 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt2"];
    [self.view addSubview:self.saveButton];
    
    if (self.locktype == FingureEntryptType) {
        self.optView1.select = YES;
    }

    if (self.locktype == PwdEntryptType) {
        self.optView2.select = YES;
        self.optView2.pwdContent = self.pwd;
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"checkButton.selected"]) {
        if ([((__bridge NSString *)context) isEqualToString:@"opt1"]) {
            if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
                self.optView2.select = NO;
            }
        }else if ([((__bridge NSString *)context) isEqualToString:@"opt2"]){
            if ([change[NSKeyValueChangeNewKey] boolValue] == YES) {
                self.optView1.select = NO;
            }
        }
    }
    
}

- (void)saveAction{
    
    NSString *entryType;
    if (self.optView1.isSelected) {
        entryType = FingureEntryptType;
    }else if (self.optView2.isSelected) {
        entryType = PwdEntryptType;
        if(self.optView2.pwdContent.length == 0){
            [self showTips:LocalizedString(@"pleaseSetPwd")  type:AlertViewTypeSuccess];
            return;
        }
    }else{
        entryType = EntryptTypeNone;
    }
    
    // use default 存储 程序加密方式及对应 密码
    NSDictionary *dic = @{@"lockType":entryType,@"pwd":self.optView2.pwdContent};
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:APPLOCKKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:APPLOCKKEY];
    NSLog(@"dict = %@",dict);
    
    if (self.eventClourse) {
        self.eventClourse(self.optView2.pwdContent,entryType);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
