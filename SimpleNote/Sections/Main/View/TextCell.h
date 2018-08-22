//
//  ImgCell.h
//  SimpleNote
//
//  Created by admin on 2018/8/21.
//  Copyright © 2018年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end