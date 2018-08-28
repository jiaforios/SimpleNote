//
//  RotationView.h
//  SimpleNote
//
//  Created by admin on 2018/8/28.
//  Copyright © 2018年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RotationModel:NSObject

@property(nonatomic,copy)NSString *originImgPath;
@property(nonatomic,copy)NSString *thumbImgPath;
@property(nonatomic,strong)UIImage *originImg;
@property(nonatomic,strong)UIImage *thumbImg;
@end

@interface RotationView : UIView


- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray<UIImage *>*)arr;

- (void)animation;

@end
