//
//  WaterFall.m
//  瀑布流
//
//  Created by 龚欣 on 15/6/19.
//  Copyright (c) 2015年 gong. All rights reserved.
//

#import "WaterFall.h"
#import "Shop.h"
#define totalCol 3

@interface WaterFall ()

@property (nonatomic,strong) NSMutableArray *attris;

@end

@implementation WaterFall

- (void)prepareLayout{
    NSLog(@"%s",__FUNCTION__);
    CGFloat itemWidth = (self.collectionView.bounds.size.width - totalCol * (self.minimumInteritemSpacing -1 ))/totalCol;
    NSLog(@"%f",itemWidth);
    [self attributes:itemWidth];
    
    self.itemSize = CGSizeMake(116, 140);
    
}

- (void)attributes:(CGFloat)itemWidth{

    CGFloat colHeight[totalCol];
    for (int i = 0; i<totalCol; i++) {
        colHeight[i] = self.sectionInset.top;
    }
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.shopList.count];
    NSInteger index = 0;
    for (Shop *shop in self.shopList) {
        
        NSInteger col = index % totalCol;
        
        CGFloat x = (self.minimumInteritemSpacing + itemWidth) * col;
        CGFloat y =  colHeight[col];
        
        CGFloat height = (CGFloat)shop.h * itemWidth / shop.w ;
        colHeight[col] += height + self.minimumLineSpacing;
        CGRect frame = CGRectMake(x, y, itemWidth, height);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [arrayM addObject:attributes];
        
        index ++;
    }
    [self.attris addObjectsFromArray:arrayM.copy];
    NSLog(@"%@",self.attris);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attris;
}



- (NSMutableArray *)attris{
    if (_attris == nil){
        _attris = [NSMutableArray array];
    }
    return _attris;
}

@end
