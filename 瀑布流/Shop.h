//
//  Shop.h
//  瀑布流
//
//  Created by 龚欣 on 15/6/19.
//  Copyright (c) 2015年 gong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject
@property (nonatomic,assign) float w;
@property (nonatomic,assign) float h;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *img;

+ (instancetype)shopWithDict:(NSDictionary *)dict;
+ (NSArray *)shopsWithIndex:(NSInteger)index;

@end
