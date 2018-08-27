//
//  ColorViewController.m
//  SimpleNote
//
//  Created by admin on 2018/8/27.
//  Copyright © 2018年 com. All rights reserved.
//

#import "ColorViewController.h"
#import "ColorCell.h"

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *headIdentifier = @"headIdentifier";

@interface ColorViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *colltionView;
@property(nonatomic, strong)NSMutableArray<UIImage *> *sourceArr;
@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UIImageView *currentImgv;
@property(nonatomic, strong)UILabel *label0;
@property(nonatomic, strong)UILabel *label1;

@end

@implementation ColorViewController


- (UILabel *)label0{
    if (!_label0) {
        _label0 = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 30)];
        _label0.text = LocalizedString(@"curentSelect");
        _label0.textAlignment = NSTextAlignmentLeft;
        _label0.font = [UIFont systemFontOfSize:14];
        _label0.textColor = TextColor;

    }
    return _label0;
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.currentImgv.frame)+25, 100, 30)];
        _label1.text = LocalizedString(@"goodstyle");
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textAlignment = NSTextAlignmentLeft;
        _label1.textColor = TextColor;
    }
    return _label1;
}

- (UIImageView *)currentImgv{
    if (!_currentImgv) {
        _currentImgv = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label0.frame)+20, 80, 80)];
        _currentImgv.layer.borderWidth = 1;
        _currentImgv.layer.borderColor = [UIColor brownColor].CGColor;
        _currentImgv.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:APPCOLORIMAGE]];
    }
    return _currentImgv;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        _selectButton.frame = CGRectMake(0, CGRectGetMaxY(self.colltionView.frame)+30, MZWIDTH,50);
        [_selectButton setTitle:LocalizedString(@"choose") forState:UIControlStateNormal];
        _selectButton.backgroundColor = [UIColor whiteColor];
        _selectButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_selectButton setTitleColor:AppColor forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (NSMutableArray<UIImage *> *)sourceArr{
    if (!_sourceArr) {
        _sourceArr = [NSMutableArray new];
        for (int i=0; i<8; i++) {
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"bg_%d",i+1]];
            if (img != nil) {
                [_sourceArr addObject:img];
            }
        }
    }
    return _sourceArr;
}

- (UICollectionView *)colltionView{
    if (!_colltionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 80);
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        int rows = (int)(self.sourceArr.count / (int)((MZWIDTH-10)/90.0)); // 计算出占了几行
        _colltionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label1.frame)+20, MZWIDTH, rows*80+(rows-1)*10+20*2) collectionViewLayout:layout];
        _colltionView.delegate = self;
        _colltionView.dataSource = self;
        _colltionView.backgroundColor = [UIColor whiteColor];
        [_colltionView registerClass:[ColorCell class] forCellWithReuseIdentifier:cellIdentifier];        
    }
    
    return _colltionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主题设置";
    [self.view addSubview:self.label0];
    [self.view addSubview:self.currentImgv];
    [self.view addSubview:self.label1];
    [self.view addSubview:self.colltionView];
    [self.view addSubview:self.selectButton];
}

- (void)selectAction{
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ColorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell cellImage:self.sourceArr[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *imge = self.sourceArr[indexPath.row];
    self.currentImgv.image = imge;
    [[NSNotificationCenter defaultCenter] postNotificationName:AppColorChangeNotification object:nil userInfo:@{@"color":imge}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
