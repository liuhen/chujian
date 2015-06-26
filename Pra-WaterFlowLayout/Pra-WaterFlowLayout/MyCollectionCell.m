//
//  MyCollectionCell.m
//  Pra-WaterFlowLayout
//
//  Created by lanou3g on 15/6/25.
//  Copyright (c) 2015年 流痕. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_imageView];
    
}


@end
