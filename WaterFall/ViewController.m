//
//  ViewController.m
//  WaterFall
//
//  Created by 王盛魁 on 16/2/25.
//  Copyright © 2016年 wangsk. All rights reserved.
//
#define imageurl @"http://i1.15yan.guokr.cn/u0bk6rs5q79lnochkx3vj1ki18zjcobh.jpg!content"

#define HTTPURL @"http://apis.guokr.com/handpick/article.json?limit=%ld&ad=1&category=all&retrieve_type=by_since"

#define kWidth    [UIScreen mainScreen].bounds.size.width
#define kHeight    [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import "CollectionLayout.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CollectionLayoutDelgate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *mutArrayHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mutArrayHeight = [NSMutableArray array];
    for (int i = 1; i < 30; i++) {
        [self.mutArrayHeight  addObject:[NSString stringWithFormat:@"%d",arc4random() % 100 + 30 ]];
    }

    [self arrangeUIView]; // 布局界面
}

#pragma mark - 布局界面
- (void)arrangeUIView{
    // 自定义layout
    CollectionLayout *layout = [[CollectionLayout alloc]init];
    layout.delgegate = self;
    layout.intNumberOfColum = 2;
    layout.fMinItemSpace = 5;
    layout.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"WaterFallCell"];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.mutArrayHeight.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterFallCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random() % 256/255.0 green:arc4random() % 256/255.0 blue:arc4random() % 256/255.0 alpha:0.5];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"clickAction__section:-%ld__row:__%ld",indexPath.section,indexPath.row);
}

#pragma mark - CollectionLayoutDelgate
// 每个item的高度
- (CGFloat)itemHeightWithLayout:(CollectionLayout *)layout IndexPath:(NSIndexPath *)indexPath{
    return [self.mutArrayHeight[indexPath.row] floatValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
