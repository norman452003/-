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

@property (nonatomic,strong) NSArray *attris;

@end

@implementation WaterFall


//如果想实现瀑布流效果，必须实现下面2个方法，且必须计算每个item对应的frame
- (void)prepareLayout{
    CGFloat itemWidth = (self.collectionView.bounds.size.width - totalCol * (self.minimumInteritemSpacing -1 ))/totalCol;
    [self attributes:itemWidth];
    
}

- (void)attributes:(CGFloat)itemWidth{

    //定义一个列高数组记录每一列的高度
    CGFloat colHeight[totalCol];
    for (int i = 0; i<totalCol; i++) {
        colHeight[i] = self.sectionInset.top;
    }
    //每一列出现的次数
    NSInteger colCount[totalCol] = {0};
    
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.shopList.count];
    NSInteger index = 0;
    CGFloat totalHeight = 0;
    for (Shop *shop in self.shopList) {
        
//        NSInteger col = index % totalCol;
        //向高度最低的那一列插入图片
        NSInteger col = [self lowestCol:colHeight];
        colCount[col]++;
        
        CGFloat x = (self.minimumInteritemSpacing + itemWidth) * col;
        CGFloat y =  colHeight[col];
        
        //等比例缩放图片
        CGFloat height = (CGFloat)shop.h * itemWidth / shop.w ;
        totalHeight += height;
        //每一行高度的累加（包括行与行之间的间距）
        colHeight[col] += height + self.minimumLineSpacing;
        CGRect frame = CGRectMake(x, y, itemWidth, height);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attributes.frame = frame;
        [arrayM addObject:attributes];
        
        index ++;
    }
    
    NSInteger highestIndex = [self hightestCol:colHeight];
    CGFloat h = (colHeight[highestIndex] - self.minimumLineSpacing * colCount[highestIndex]) / colCount[highestIndex];
    self.itemSize = CGSizeMake(itemWidth, h);
    
    UICollectionViewLayoutAttributes *bottomAttri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    bottomAttri.frame = CGRectMake(0, colHeight[highestIndex]-self.minimumLineSpacing, self.collectionView.bounds.size.width, 44);
    [arrayM addObject:bottomAttri];
    
    self.attris = arrayM.copy;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attris;
}

- (NSInteger)hightestCol:(CGFloat *)colHeight{

    CGFloat max = 0;
    NSInteger index = 0;
    for (int i = 0; i<totalCol; i++) {
        if (colHeight[i] > max){
            max = colHeight[i];
            index = i;
        }
    }
    return index;
}

- (NSInteger)lowestCol:(CGFloat *)colHeight{

    CGFloat min = MAXFLOAT;
    NSInteger index = 0;
    for (int i =0 ; i<totalCol; i++) {
        if (colHeight[i] < min){
            min = colHeight[i];
            index = i;
        }
    }
    return index;
}


@end
