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
#import "FootCollectionView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet WaterFall *flowLayOut;
@property (nonatomic,strong) NSMutableArray *shopList;
@property (nonatomic,weak) FootCollectionView *footView;
@property (nonatomic,assign,getter=isLoading) BOOL loading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData{

    static NSInteger index = 0;
    [self.shopList addObjectsFromArray:[Shop shopsWithIndex:index]];
    self.flowLayOut.shopList = self.shopList;
    
    index ++;
    [self.collectionView reloadData];
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
       self.footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        return self.footView;
    }
    
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.footView == nil || self.isLoading){
        return;
    }
    if ((scrollView.contentOffset.y + [UIScreen mainScreen].bounds.size.height) > self.footView.frame.origin.y){
        [self.footView.indicator startAnimating];
        self.loading = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"123");
            [self loadData];
            self.loading = NO;
//            [self.footView.indicator stopAnimating];
            self.footView = nil;
            
        });
    }
    
}

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
