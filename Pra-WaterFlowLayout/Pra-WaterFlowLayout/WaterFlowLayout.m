//
//  WaterFlowLayout.m
//  Pra-WaterFlowLayout
//
//  Created by lanou3g on 15/6/25.
//  Copyright (c) 2015年 流痕. All rights reserved.
//

#import "WaterFlowLayout.h"

//延展
@interface WaterFlowLayout ()

//item总数
@property (nonatomic, assign)NSUInteger numberOfItems;
//保存每一列高度
@property (nonatomic, strong)NSMutableArray *columnHeights;
//用来保存每一个item计算好的属性(x, y, w, h)
@property (nonatomic, strong)NSMutableArray *itemAttributes;

//获取最长索引 (计算contentView高度)
- (NSInteger)p_indexForLongestColumn;
- (NSInteger)p_indexForShortestColumn;

@end
@implementation WaterFlowLayout

//懒加载
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)itemAttributes
{
    if (!_itemAttributes) {
        self.itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

//获取最长索引列
- (NSInteger)p_indexForLongestColumn
{
    NSInteger longestIndex = 0;
    //
    CGFloat longestHeight = 0;
    
    for (int i = 0; i < self.numberOfColumns; i ++) {
        //
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (currentHeight > longestHeight) {
            longestHeight = currentHeight;
            longestIndex = i;
        }
        
    }
    
    return longestIndex;
}

//获取最短列索引
- (NSInteger)p_indexForShortestColumn
{
    NSInteger shortestIndex = 0;
    CGFloat shortestHeight = MAXFLOAT;
    
    for (int i = 0; i < self.numberOfColumns; i ++) {
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (currentHeight < shortestHeight) {
            shortestHeight = currentHeight;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

//准备布局
- (void)prepareLayout
{
    //调用父类布局
    [super prepareLayout];
    //给每一列添加top高度
    for (int i = 0; i < self.numberOfColumns; i ++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    
    //获取item数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    //为每一个item 设置frame 和 indexPath
    for (int i = 0; i < self.numberOfItems; i ++) {
        //
        //查找最短队列
        NSInteger shortestIndex = [self p_indexForShortestColumn];
        CGFloat shortestHeight = [self.columnHeights[shortestIndex] floatValue];
        
        //计算x值, y值: 内边距left  + (item.w + item.间距)*索引
        CGFloat detailX = self.sectionInsets.left + (self.itemSize.width + self.insetItemSpacing)*shortestIndex;
        //
        CGFloat detailY = shortestHeight + self.insetItemSpacing;
        //设置indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //设置属性
        UICollectionViewLayoutAttributes *layoutArr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //保存item的高
        CGFloat itemHeight = 0;
        //判断是否设置代理
        if (_delegate && [_delegate respondsToSelector:@selector(heightForItemIndexPath:)]) {
            //使用代理方法获取item的高
            itemHeight = [_delegate heightForItemIndexPath:indexPath];
        }
        
        //设置frame
        layoutArr.frame = CGRectMake(detailX, detailY, self.itemSize.width, itemHeight);
        
        //放入数组
        [self.itemAttributes addObject:layoutArr];
        //更新高度
        self.columnHeights[shortestIndex] = @(detailY + itemHeight);
    }
    
}

//计算contentView大小
- (CGSize)collectionViewContentSize
{
    //
    NSInteger longestIndex = [self p_indexForLongestColumn];
    CGFloat longestHeight = [self.columnHeights[longestIndex] floatValue];
    CGSize contentSize = self.collectionView.frame.size;
    //
    contentSize.height = longestHeight + self.sectionInsets.bottom;
    return contentSize;
    
}

//返回每一个item的attribute
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}










@end
