//
//  MJExtenView.h
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/8/24.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJExtenView : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *currentInMaxProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *curDiskInMaxProgress;
- (void)calculateProgress;
@end
