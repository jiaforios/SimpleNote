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
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *lockImg;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *remindImg;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remindTimeLabel;

- (void)showWithData:(NSDictionary *)dic;

@end
