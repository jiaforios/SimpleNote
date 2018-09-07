//
//  EncryptViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/24.
//  Copyright © 2018年 com. All rights reserved.
//

#import "EncryptViewController.h"
#import "OptionView.h"

@interface EncryptViewController ()

@property(nonatomic, strong)OptionView *optView1;
@property(nonatomic, strong)OptionView *optView2;
@property(nonatomic, strong)UITextField *textField;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIButton *saveButton;

@end

@implementation EncryptViewController

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.optView2.frame)+20, 10, 30)];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = TextColor;
        _label.text = LocalizedString(@"contentTips");
        [_label sizeToFit];
    }
    return _label;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField.frame)+25, MZWIDTH-60, 44)];
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

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(32, CGRectGetMaxY(self.label.frame)+15, MZWIDTH-64, 50)];
        _textField.placeholder = LocalizedString(@"entryptTips");
        _textField.textColor = AppColor;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.text = self.lockTips;
        _textField.background = [UIImage imageNamed:@"input_line"];
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"加密设置";
    
    [self.view addSubview:self.optView1];
    [self.view addSubview:self.optView2];
    
    [self.optView1 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt1"];
    [self.optView2 addObserver:self forKeyPath:@"checkButton.selected" options:NSKeyValueObservingOptionNew context:@"opt2"];
    [self.view addSubview:self.label]; 
    [self.view addSubview:self.textField];
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
    }else
    if (self.optView2.isSelected) {
        entryType = PwdEntryptType;
        if(self.optView2.pwdContent.length == 0){
            [self showTips:LocalizedString(@"pleaseSetPwd") type:AlertViewTypeSuccess];
            return;
        }
    }else{
        entryType = EntryptTypeNone;
    }

    if (self.eventClourse) {
        self.eventClourse(self.optView2.pwdContent,entryType,self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
