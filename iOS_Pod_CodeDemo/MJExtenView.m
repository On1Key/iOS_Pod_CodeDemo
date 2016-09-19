//
//  MJExtenView.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/8/24.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "MJExtenView.h"

@implementation MJExtenView

- (void)calculateProgress{
    NSArray *curArr = [self.currentContentLabel.text componentsSeparatedByString:@"/"];
    NSArray *maxArr = [self.maxContentLabel.text componentsSeparatedByString:@"/"];
    
    float memoCur = 0;
    float memoMax = 4;
    float diskCur = 0;
    float diskMax = 20;
    if (curArr.count >= 2) {
        memoCur = [curArr[0] floatValue];
        diskCur = [curArr[1] floatValue];
    }
    if (maxArr.count >= 2) {
        memoMax = [maxArr[0] floatValue];
        diskMax = [maxArr[1] floatValue];
    }
    self.currentInMaxProgress.progress = memoCur / memoMax;
    self.curDiskInMaxProgress.progress = diskCur / diskMax;
    
}

@end
