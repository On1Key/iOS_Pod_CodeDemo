//
//  XibFrameCell.h
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XibModel.h"

@interface XibFrameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UIImageView *infoIV;
@property (nonatomic, strong) XibModel *xibModel;
@end
