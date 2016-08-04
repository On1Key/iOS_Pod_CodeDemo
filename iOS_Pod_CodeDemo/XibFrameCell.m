//
//  XibFrameCell.m
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "XibFrameCell.h"

@implementation XibFrameCell


- (void)setXibModel:(XibModel *)xibModel{
    _xibModel = xibModel;
    self.headerIV.image = [UIImage imageNamed:xibModel.headerUrl];
    self.nameLab.text = xibModel.name;
    self.infoIV.image = [UIImage imageNamed:xibModel.infoUrl];
    self.infoLab.text = xibModel.info;
//        [self layoutIfNeeded];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__func__);
//    self.contentView.width = SCREEN_WIDTH;
    self.contentView.bounds = [UIScreen mainScreen].bounds;
    // Initialization code
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.width = SCREEN_WIDTH;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.headerIV sizeThatFits:size].height;
    totalHeight += [self.infoLab sizeThatFits:size].height;
    totalHeight += [self.infoIV sizeThatFits:size].height;
    totalHeight += 40; // margins
    return CGSizeMake(size.width, totalHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
NSLog(@"%s",__func__);
    // Configure the view for the selected state
}

@end
