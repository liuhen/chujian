//
//  ViewController.m
//  Pra-WaterFlowLayout
//
//  Created by lanou3g on 15/6/25.
//  Copyright (c) 2015年 流痕. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "MyCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "WaterFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WaterFlowLayoutDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self p_readData];
    
    [self layoutCollectionView];
}

- (void)p_readData
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Data.json" ofType:nil]];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    for (NSDictionary *dic in dataArr) {
        //
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray array];
        }
        
        Model *data = [[Model alloc] init];
        //kvc
        [data setValuesForKeysWithDictionary:dic];
        
        [self.dataArray addObject:data];
    }
    
    
}

- (void)layoutCollectionView
{
//    //
//    WaterFlowLayout *layout = [[WaterFlowLayout alloc] init];
//    layout.delegate = self;
//    CGFloat w = ([[UIScreen mainScreen] bounds].size.width - 40) / 3;
//    layout.itemSize = CGSizeMake(w, w);
//    
//    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    layout.insetItemSpacing = 10;
//    layout.numberOfColumns = 3;
//
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    
//    [self.view addSubview:collectionView];
//    
//    //注册
//    [collectionView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 布局
    //UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
    layout.delegate = self;
    CGFloat w = ([[UIScreen mainScreen]bounds].size.width - 40) / 3; //边距 间距共40;
    // 设置size
    layout.itemSize = CGSizeMake(w, w);
    
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.insetItemSpacing = 10;
    layout.numberOfColumns = 3;
    
    // 创建collectionView
    UICollectionView *collcetView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    // 设置代理
    collcetView.dataSource = self;
    collcetView.delegate = self;
    
    [self.view addSubview:collcetView];
    
    
    // 注册
    [collcetView registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"cell"];

}

//
- (CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath
{
    //获取model对象
    Model *m = self.dataArray[indexPath.item];
    
    CGFloat w = ([[UIScreen mainScreen] bounds].size.width - 40) / 3;
    CGFloat h = (w*m.height)/m.width;
    
    return h;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for items ...");
    
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //
    Model *m = self.dataArray[indexPath.item];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:m.thumbURL]];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
