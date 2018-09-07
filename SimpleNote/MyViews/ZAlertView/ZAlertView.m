//
//  ZAlertView.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertView.h"
#import "UIColor+Hexadecimal.h"

#define Start_Height -64
#define Height 20
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 14
#define Image_Center_X 25
#define Image_Center_Y 40
#define Image_Width 20
@implementation ZAlertView
static UIWindow* _staWindow;
- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _imageView.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.frame = CGRectMake(0, 0, Screen_Width, 20);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont systemFontOfSize:Font_Size];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
        
        CGRect rect = [UIApplication sharedApplication].statusBarFrame;
        _staWindow = [[UIWindow alloc]initWithFrame:rect];
        _staWindow.backgroundColor = [UIColor clearColor];
        _staWindow.windowLevel = UIWindowLevelAlert;
        [_staWindow addSubview:self];
        
    }
    return self;
}


- (void)topAlertViewContent:(NSString *)content Type:(AlertViewType)type{

    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            //  self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = content;
            self.tipsLabel.textColor = [UIColor whiteColor];
            self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case AlertViewTypeError:
        {
            self.backgroundColor = [UIColor blackColor];
            //  self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = content;
            self.tipsLabel.textColor = [UIColor whiteColor];
            self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
}

- (void)test_topAlertViewContent:(NSString *)content Type:(AlertViewType)type{
#ifdef RELEASE
    return;
#endif
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.backgroundColor = RGB(255, 69, 0);
            //  self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = content;
            self.tipsLabel.textColor = [UIColor whiteColor];
            self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case AlertViewTypeError:
        {
            self.backgroundColor = RGB(255, 69, 0);
            //  self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = content;
            self.tipsLabel.textColor = [UIColor whiteColor];
            self.tipsLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
            
        default:
            break;
    }
}
- (void)topAlertViewTypewWithType:(AlertViewType)type
{
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.backgroundColor = [UIColor colorWithHexString:@"#dbdbdb"];
            self.imageView.image = [UIImage imageNamed:@"success"];
            self.tipsLabel.text = @"Success!";
            self.tipsLabel.textColor = [UIColor darkTextColor];
        }
            break;
        case AlertViewTypeError:
        {
            self.backgroundColor = [UIColor colorWithHexString:@"#d4237a"];
            self.imageView.image = [UIImage imageNamed:@"error"];
            self.tipsLabel.text = @"Error!";
            self.tipsLabel.textColor = [UIColor groupTableViewBackgroundColor];
        }
            break;

        default:
            break;
    }

}

- (void)show
{
    [UIView animateWithDuration:0.25 animations:^{
        _staWindow.hidden = NO;
        self.center = CGPointMake(self.center.x, 10);
    }];
}

- (void)dismiss
{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.center = CGPointMake(self.center.x, -32);
    } completion:^(BOOL finished) {
        _staWindow.hidden = YES;
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
