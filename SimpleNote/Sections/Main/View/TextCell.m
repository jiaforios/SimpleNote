//
//  TextCell.m
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import "TextCell.h"

@interface TextCell ()

@end

@implementation TextCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self.editButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5,10, 5)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
