//
//  NoteViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()<UITextViewDelegate>

@property(nonatomic, strong)UITextView *noteTextView;
@property(nonatomic, strong)UIButton *saveButton;

@end

@implementation NoteViewController


- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.frame = CGRectMake(0, 0, 44,44);
        [_saveButton setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}


- (UITextView *)noteTextView{
    if (!_noteTextView) {
        _noteTextView = [[UITextView alloc] initWithFrame: CGRectMake(15, kNavBarHeight+15, MZWIDTH-30, MZHEIGHT*0.4)];
        _noteTextView.backgroundColor = [UIColor whiteColor];
        _noteTextView.font = [UIFont systemFontOfSize:14];
        _noteTextView.layer.cornerRadius = 6;
        _noteTextView.clipsToBounds = YES;
        _noteTextView.delegate = self;
        
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"  ";
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(240, 240, 240);
    self.title = @"新增";
    UIBarButtonItem *set = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    self.navigationItem.rightBarButtonItem = set;
    [self.view addSubview:self.noteTextView];
    
}

- (void)saveAction{
    NSLog(@"保存");
}

-(void)textViewDidChange:(UITextView *)textView{
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:textView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[self paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    textView.attributedText  = strM;
    
}

- (NSMutableParagraphStyle *)paraStyle{
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8.;// 行间距
    paragraphStyle.lineHeightMultiple = 1.3;// 行高倍数（1.5倍行高）
    paragraphStyle.firstLineHeadIndent = 30.0f;//首行缩进
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.alignment = NSTextAlignmentLeft;// 对齐方式
    paragraphStyle.defaultTabInterval = 144;// 默认Tab 宽度
    paragraphStyle.headIndent = 10;// 起始 x位置
    return paragraphStyle;
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
