//
//  Shop.m
//  瀑布流
//
//  Created by 龚欣 on 15/6/19.
//  Copyright (c) 2015年 gong. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (instancetype)shopWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

+ (NSArray *)shopsWithIndex:(NSInteger)index{

    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%ld.plist",index % 3 + 1] ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArray.count];
    [dictArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[Shop shopWithDict:obj]];
    }];
    return arrayM.copy;
}


@end
