//
//  XibCell.m
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "XibCell.h"

@implementation XibCell

- (void)setXibModel:(XibModel *)xibModel{
    _xibModel = xibModel;
    self.headerIV.image = [UIImage imageNamed:xibModel.headerUrl];
    self.nameLab.text = xibModel.name;
    self.infoIV.image = [UIImage imageNamed:xibModel.infoUrl];
    self.arrowIV.image = [UIImage imageNamed:xibModel.arrow];
    self.infoLab.text = xibModel.info;
//    [self layoutIfNeeded];
}
//- (void)awakeFromNib{
//    [super awakeFromNib];
//    self.contentView.width = SCREEN_WIDTH;
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.width = SCREEN_WIDTH;
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 0;
//    totalHeight += [self.headerIV sizeThatFits:size].height;
//    totalHeight += [self.infoLab sizeThatFits:size].height;
//    totalHeight += [self.infoIV sizeThatFits:size].height;
//    totalHeight += 40; // margins
//    return CGSizeMake(size.width, totalHeight);
//}
@end
