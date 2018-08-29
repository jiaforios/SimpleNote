//
//  OptionsViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//

#import "OptionsViewController.h"
#import <BmobSDK/Bmob.h>
#import "LoadButton.h"

@interface OptionsViewController ()<UITextViewDelegate>
@property(nonatomic, strong)UITextView *noteTextView;
@property(nonatomic, strong)LoadButton *saveButton;
@end

@implementation OptionsViewController
- (UITextView *)noteTextView{
    if (!_noteTextView) {
        _noteTextView = [[UITextView alloc] initWithFrame: CGRectMake(15, 15, MZWIDTH-30, MZHEIGHT*0.3)];
        _noteTextView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _noteTextView.font = [UIFont systemFontOfSize:14];
        _noteTextView.layer.cornerRadius = 6;
        _noteTextView.clipsToBounds = YES;
        _noteTextView.delegate = self;
        _noteTextView.textColor = TextColor;
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"在这里输入内容";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor =RGB(210, 210, 210);
        [placeHolderLabel sizeToFit];
        [_noteTextView addSubview:placeHolderLabel];
        _noteTextView.font = [UIFont systemFontOfSize:14.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:14.f];
        [_noteTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return _noteTextView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[LoadButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.noteTextView.frame)+25, MZWIDTH-60, 44)];
        _saveButton.layer.cornerRadius = 10;
        _saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_saveButton setTitleColor:AppColor forState:UIControlStateNormal];
        _saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [_saveButton setTitle:LocalizedString(@"sublimt") forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self.view addSubview:self.noteTextView];
    [self.view addSubview:self.saveButton];
}

- (void)saveAction{
    [self.view resignFirstResponder];
    if (_noteTextView.text.length == 0) {
        [[ZAlertViewManager shareManager] showContent:LocalizedString(@"contentNull") type:AlertViewTypeError];
        return;
    }
    [self.saveButton toggle];
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
    BmobObject *gameScore = [BmobObject objectWithClassName:@"userOptions"];
    [gameScore setObject:_noteTextView.text forKey:@"content"];
    [gameScore setObject:uuid forKey:@"uuid"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        [self.saveButton endLoading];
        //进行操作
        if (isSuccessful) {
            [self showTips:LocalizedString(@"sublimtSuc")  type:AlertViewTypeError];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [[ZAlertViewManager shareManager] showContent:LocalizedString(@"sublimtFail") type:AlertViewTypeError];
            [self showTips:LocalizedString(@"sublimtFail")  type:AlertViewTypeError];
        }
    }];
    
    
}
-(void)textViewDidChange:(UITextView *)textView{
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[Utils paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    textView.attributedText  = strM;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
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
