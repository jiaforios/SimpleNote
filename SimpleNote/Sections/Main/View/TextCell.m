//
//  TextCell.m
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import "TextCell.h"
#import "ZJTools.h"
#import "NoteManager.h"

@interface TextCell ()
@property(nonatomic, strong)UIVisualEffectView *visView;
@end

@implementation TextCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self.editButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5,10, 5)];
//    self.coverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lock_bg_2"]];
    self.coverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_8"]];

}

-(UIVisualEffectView*)visView{
    if (_visView == nil) {
        _visView = [ZJTools effectViewWithFrame:self.coverView.bounds];
        _visView.alpha = 0.7;
    }
    return _visView;
}

- (void)showWithData:(NSDictionary *)dic{
    self.contentLabel.numberOfLines = 0;
    self.timeLabel.text= dic[@"dateStr"];    
    self.coverView.hidden = ![dic[@"lock"] boolValue];
    self.tipLabel.text = dic[@"lockTitle"];
    if ([dic[@"lockType"] isEqualToString:FingureEntryptType]) {
        self.lockImg.image = [UIImage imageNamed:@"fingure_entrypt"];
    }
    
    if ([dic[@"lockType"] isEqualToString:PwdEntryptType]) {
        self.lockImg.image = [UIImage imageNamed:@"pwd_entrypt"];
    }
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:dic[@"content"] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSKernAttributeName:@3,NSParagraphStyleAttributeName:[Utils paraStyle]}];
    NSMutableAttributedString *strM = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
    self.contentLabel.attributedText = strM;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
