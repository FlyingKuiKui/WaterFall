//
//  CollectionLayout.h
//  WaterFall
//
//  Created by 王盛魁 on 16/2/25.
//  Copyright © 2016年 wangsk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionLayout;

@protocol CollectionLayoutDelgate <NSObject>
/**
 *  设置每个item自身的高度
 *
 *  @param  layout
 *  
 *  @param  indexPath  所在的位置
 *
 *  @return 高度
 *
 */
- (CGFloat)itemHeightWithLayout:(CollectionLayout *)layout IndexPath:(NSIndexPath *)indexPath;


@end

@interface CollectionLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <CollectionLayoutDelgate> delgegate;
/**
 * 列数
 */
@property (nonatomic, assign) NSInteger intNumberOfColum;
/**
 * item间的最小间隔
 */
@property (nonatomic, assign) CGFloat fMinItemSpace;
/**
 *  整个CollectionView的间隔
 */
@property (nonatomic, assign)UIEdgeInsets edgeInsets;

@end
