//
//  WaterFlowLayout.h
//  Pra-WaterFlowLayout
//
//  Created by lanou3g on 15/6/25.
//  Copyright (c) 2015年 流痕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowLayoutDelegate <NSObject>

//获取item高度
- (CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowLayout : UICollectionViewLayout

////item
//@property (nonatomic, assign)CGSize itemSize;
////
//@property (nonatomic, assign)UIEdgeInsets sectionInsets;
////
//@property (nonatomic, assign)CGFloat insetItemSapcing;
////列数
//@property (nonatomic, assign)NSUInteger numberOfColumns;
//
//
// item大小
@property (nonatomic,assign)CGSize itemSize;
// 内间距
@property (nonatomic,assign)UIEdgeInsets sectionInsets;
// item间距
@property (nonatomic,assign)CGFloat insetItemSpacing;
// 列数
@property (nonatomic,assign)NSUInteger numberOfColumns;


@property (nonatomic, weak)id<WaterFlowLayoutDelegate>delegate;

@end
