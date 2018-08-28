//
//  RotationView.m
//  SimpleNote
//
//  Created by admin on 2018/8/28.
//  Copyright © 2018年 com. All rights reserved.
//

#import "RotationView.h"

@interface RotationView ()
{
    NSArray *_imgArr;
}
@end

@implementation RotationView

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray<UIImage *>*)arr{
    if (self = [super initWithFrame:frame]) {
        _imgArr = arr;
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    
    return self;
}

- (void)setupView{
    
    for (int i = 0; i<_imgArr.count; i++) {
        RotationModel *model = [RotationModel new];
        model.thumbImg = _imgArr[i];
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:self.bounds];
        imgv.image = _imgArr[i];
        if (i != _imgArr.count - 1) {
            if (i%2==0) {
                imgv.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -10-i*10, 0);
            }else{
                imgv.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 10+i*10, 0);
            }
        }
        
        [self addSubview:imgv];
    }
}


- (void)animation{
    static int a = 0;
    for (UIView *v in self.subviews) {
        a++;
        CGAffineTransform old = v.transform;
        if (a%2==0) {
            [UIView animateWithDuration:0.5 animations:^{
                v.transform = CGAffineTransformTranslate(old, -10-a*10, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    v.transform = old;
                }];
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                v.transform = CGAffineTransformTranslate(old, 10+a*10, 0);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    v.transform = old;
                }];
            }];
        }
        
     
    }
    a = 0;
}

@end



@implementation RotationModel


@end
