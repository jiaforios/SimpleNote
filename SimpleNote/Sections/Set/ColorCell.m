//
//  ColorCell.m
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//

#import "ColorCell.h"
#import <Masonry.h>

@interface ColorCell ()

@property(nonatomic, strong)UIImageView *colorImg;

@end

@implementation ColorCell

- (UIImageView *)colorImg{
    if (!_colorImg) {
        _colorImg = [[UIImageView alloc] init];
    }
    return _colorImg;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.colorImg];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.colorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (void)cellImage:(UIImage *)img{
    self.colorImg.image = img;
}

@end
