//
//  ViewController.m
//  瀑布流
//
//  Created by 龚欣 on 15/6/19.
//  Copyright (c) 2015年 gong. All rights reserved.
//

#import "ViewController.h"
#import "Shop.h"
#import "WaterFall.h"
#import "ShopCell.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet WaterFall *flowLayOut;
@property (nonatomic,strong) NSMutableArray *shopList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataWithIndex:1];
}

- (void)loadDataWithIndex:(NSInteger)index{

   [self.shopList addObjectsFromArray:[Shop shopsWithIndex:index]];
    self.flowLayOut.shopList = self.shopList;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.shopList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopcell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    cell.shop = self.shopList[indexPath.item];
    
    return cell;
    
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
//        return footView;
//    }
//    
//    return nil;
//}

- (NSMutableArray *)shopList{
    if (_shopList == nil){
        _shopList = [NSMutableArray array];
    }
    return _shopList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
