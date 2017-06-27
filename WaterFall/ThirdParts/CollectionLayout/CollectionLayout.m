//
//  CollectionLayout.m
//  WaterFall
//
//  Created by 王盛魁 on 16/2/25.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import "CollectionLayout.h"

@interface CollectionLayout ()

@property (nonatomic, strong) NSMutableArray *marrayColumHeight; // 行高数组
@property (nonatomic, strong) NSMutableArray *marrayAttribute;
@end

@implementation CollectionLayout
// 重写setter方法
- (void)setIntNumberOfColum:(NSInteger)intNumberOfColum{
    if (_intNumberOfColum != intNumberOfColum) {
        _intNumberOfColum = intNumberOfColum;
        // 重新布局
        [self invalidateLayout];
    }
}

- (void)setFMinItemSpace:(CGFloat)fMinItemSpace{
    if (_fMinItemSpace != fMinItemSpace) {
        _fMinItemSpace = fMinItemSpace;
        [self invalidateLayout];
    }
}
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
        [self invalidateLayout];
    }
}

// 重写父类方法
- (void)prepareLayout{
    [super prepareLayout];
    self.marrayColumHeight = [NSMutableArray arrayWithCapacity:self.intNumberOfColum];
    self.marrayAttribute = [NSMutableArray array];
    for (int index = 0; index < self.intNumberOfColum; index++) {
        self.marrayColumHeight[index] = @(self.edgeInsets.top);
    }
    // 行 宽度
    CGFloat fLineWidth = self.collectionView.frame.size.width;
    // 每行 所有item的总宽度
    CGFloat fItemSumWidth = fLineWidth - self.edgeInsets.left - self.edgeInsets.right - self.fMinItemSpace * (self.intNumberOfColum - 1);
    // 每个item的宽度
    CGFloat fItemWidth = fItemSumWidth / self.intNumberOfColum;
    // 某个分区的item个数
    NSInteger intItemNumber = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < intItemNumber; i++) {
        NSInteger intMinIndex = [self indexOfMinItemHeight];
        
        CGFloat xPos = self.edgeInsets.left + (fItemWidth + self.fMinItemSpace) * intMinIndex;
        CGFloat yPos = [self.marrayColumHeight[intMinIndex] floatValue];

        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        // item的高度
        CGFloat fItemHeight;
        // 代理
        if (self.delgegate && [self.delgegate respondsToSelector:@selector(itemHeightWithLayout:IndexPath:)]) {
            fItemHeight = [self.delgegate itemHeightWithLayout:self IndexPath:indexPath];
        }else{
            fItemHeight = 44.f;
        }
        CGRect frame = CGRectMake(xPos, yPos, fItemWidth, fItemHeight);
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = frame;
        [self.marrayAttribute addObject:attribute];
        
        CGFloat fNewHeight = [self.marrayColumHeight[intMinIndex] floatValue] + fItemHeight + self.fMinItemSpace;
        self.marrayColumHeight[intMinIndex] = @(fNewHeight);
    }
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *marrayResult = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in self.marrayAttribute) {
        CGRect rect1 = attributes.frame;
        if (CGRectIntersectsRect(rect1, rect)) {
            [marrayResult addObject:attributes];
        }
    }
    return marrayResult;
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger index = [self indexOfMaxItemHeigh];
    CGFloat height = [self.marrayColumHeight[index] floatValue];
    return CGSizeMake(width, height);
}

// 获取item高度为最大值的下标位置
- (NSInteger)indexOfMaxItemHeigh{
    __block CGFloat fMaxItemHeight = 0.0;
    __block NSInteger intMaxIndex = 0;
    __weak typeof(self) weakSelf = self;
    [self.marrayColumHeight enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat fHeight = [weakSelf.marrayColumHeight[idx] floatValue];
        if (fHeight > fMaxItemHeight) {
            fMaxItemHeight = fHeight;
            intMaxIndex = idx;
        }
    }];
    return intMaxIndex;
}
// 获取item高度为最小值的下标位置
- (NSInteger)indexOfMinItemHeight{
    __block CGFloat fMinItemHeight = MAXFLOAT;
    __block NSInteger intMinIndex = 0;
    __weak typeof(self) weakSelf = self;
    [self.marrayColumHeight enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat fHeight = [weakSelf.marrayColumHeight[idx] floatValue];
        if (fHeight < fMinItemHeight) {
            fMinItemHeight = fHeight;
            intMinIndex = idx;
        }
    }];
    return intMinIndex;
}





@end
