//
//  ShopCell.m
//  瀑布流
//
//  Created by 龚欣 on 15/6/20.
//  Copyright (c) 2015年 gong. All rights reserved.
//

#import "ShopCell.h"
#import "Shop.h"
#import "UIImageView+WebCache.h"
@interface ShopCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ShopCell


- (void)setShop:(Shop *)shop{
    _shop = shop;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
    self.priceLabel.text = shop.price;
}
@end
