//
//  MZBaseViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZBaseViewController.h"
#import <LEEAlert.h>

@interface MZBaseViewController ()
@property(nonatomic, strong)NSUserDefaults *user;

@end

@implementation MZBaseViewController


- (NSUserDefaults *)user{
    if (!_user) {
        _user = [NSUserDefaults standardUserDefaults];
    }
    return _user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appColorChange:) name:AppColorChangeNotification object:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self bgImage]];
//    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
  
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor brownColor]}];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    backItem.tintColor = RGB(222, 93, 0);
    //主要是以下两个图片设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[self bgImage] forBarMetrics:UIBarMetricsDefault];
    
}

// 如果
-(void)setView:(UIView *)view{
    [super setView:view];
    view.backgroundColor = [UIColor colorWithPatternImage:[self bgImage]];
}

- (UIImage *)bgImage{
    return [UIImage imageWithData:[self.user objectForKey:APPCOLORIMAGE]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
}


- (void)showAlertViewTitle:(NSString *)title message:(NSString *)message sureBlock:(void(^)(void))sBlock{
    
    [LEEAlert alert].config
    .LeeTitle(title)
    .LeeContent(message)
    .LeeCancelAction(LocalizedString(@"cancel"), ^{
        
    })
    .LeeAction(LocalizedString(@"sure"), ^{
        sBlock?sBlock():nil;
    })
    .LeeShow();
    
}

- (void)showTextAlertTitle:(NSString *)title message:(NSString *)message sureBlock:(BOOL(^)(NSString*))sBlock{
    __block UITextField *tf = nil;
    [LEEAlert alert].config.LeeAddTitle(^(UILabel *label) {
        label.text = title;
    }).LeeAddTextField(^(UITextField *textField) {
        textField.textColor = AppColor;
        tf = textField;
    }).LeeAction(LocalizedString(@"sure"),^{
        if (sBlock) {
            if(!sBlock(tf.text)){
                [self showTextAlertTitle:title message:message sureBlock:sBlock];
            }
        }
    }).LeeCancelAction(LocalizedString(@"cancel"),^{
        
    }).LeeShow();
    
}

- (void)appColorChange:(NSNotification *)center{
    
    UIImage *img = [[center userInfo] objectForKey:@"color"];
    NSData *data = UIImagePNGRepresentation(img);
    [self.user setObject:data forKey:APPCOLORIMAGE];
    [self.user synchronize];

    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
}

- (void)showTips:(NSString *)title type:(AlertViewType)type{
    [[ZAlertViewManager shareManager] showContent:title type:type];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
