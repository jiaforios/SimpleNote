//
//  MZBaseViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/20.
//  Copyright © 2018年 com. All rights reserved.
//

#import "MZBaseViewController.h"

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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:LocalizedString(@"cancel") style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:LocalizedString(@"sure") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sBlock?sBlock():nil;
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)appColorChange:(NSNotification *)center{
    
    UIImage *img = [[center userInfo] objectForKey:@"color"];
    NSData *data = UIImagePNGRepresentation(img);
    [self.user setObject:data forKey:APPCOLORIMAGE];

    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
