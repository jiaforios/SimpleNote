//
//  ImagesTool.m
//  SimpleNote
//
//  Created by admin on 2018/8/30.
//  Copyright © 2018年 com. All rights reserved.
//

#import "ImagesTool.h"

@implementation ImagesTool

+ (ImagesTool *)instanceWithImages:(NSArray *)arr{
    
    // 压缩图片大小 80*80
    
    ImagesTool *view = [[ImagesTool alloc] init];
    
    [arr enumerateObjectsUsingBlock:^(UIImage * obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
//        UIImageView *imgv = [[UIImageView alloc] initWithFrame:<#(CGRect)#>]
        
    }];
    
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)makeImagesThumbCombineLong{
    
}

- (void)makeImagesThumbCombineShort{
    
}


@end
