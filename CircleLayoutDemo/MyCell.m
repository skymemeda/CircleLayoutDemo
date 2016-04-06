//
//  MyCell.m
//  CircleLayoutDemo
//
//  Created by sks on 16/4/5.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "MyCell.h"
@interface MyCell()

@end
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.picView.layer.cornerRadius = 30;
    self.picView.layer.masksToBounds = YES;
}

@end
