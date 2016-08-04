//
//  PopViewController.m
//  iOS_Pod_CodeDemo
//
//  Created by mac book on 16/7/12.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "PopViewController.h"

@interface PopViewController ()
@property (nonatomic, strong) NSArray *popTests;
@end

@implementation PopViewController
- (NSArray *)popTests{
    if (!_popTests) {
        _popTests = @[NSStringFromSelector(@selector(decay:)),
                      NSStringFromSelector(@selector(spring:)),
                      NSStringFromSelector(@selector(basic:)),
                      NSStringFromSelector(@selector(group:)),];
    }
    return _popTests;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    测试pop用法
    [self popAnimationTest];
}
#pragma mark - pop简单用法
/**
 *  ------------------------------------------------------------------
 *  pop简单用法
 */
- (void)popAnimationTest{
    
    NSInteger count = self.popTests.count;
    float percent = 0.6;
    CGFloat holderW = SCREEN_WIDTH / count;
    CGFloat btnWH = holderW * percent;
    CGFloat margin = (holderW - btnWH) * 0.5;
    
    for (int i = 0; i < count; i ++) {
        UIButton *button = [[UIButton alloc] init];
        CGFloat btnX = i * holderW + margin;
        button.frame = CGRectMake(btnX, SCREEN_HEIGHT * 0.5 - holderW, btnWH, btnWH);
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitle:_popTests[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:nil forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(self.popTests[i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
//弹性动画
- (void)spring:(UIView *)view{
    POPSpringAnimation* framePOP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    
    framePOP.springSpeed = 20.f;
    
    framePOP.springBounciness = 40.f;
    
    framePOP.toValue = [NSValue valueWithCGSize:CGSizeMake(view.width * 1.2, view.height * 1.2)];
    
    [framePOP setCompletionBlock:^(POPAnimation * anim , BOOL finsih) {
        
        if (finsih) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(view.frame));
            
        }
        
    }];
    
    [view pop_addAnimation:framePOP forKey:@"go"];
}
//减缓动画
- (void)decay:(UIView *)view{
    POPDecayAnimation* decay = [POPDecayAnimation animationWithPropertyNamed:kPOPViewFrame];
    
    //    decay.toValue = [NSValue valueWithCGRect:CGRectMake(200, 400, 100, 100)];
    
    decay.velocity = [NSValue valueWithCGRect:CGRectMake(200, 300, 100, 100)];
    
    [view pop_addAnimation:decay forKey:@"go"];
}
/**
 *  基本动画
 */
-(void)basic:(UIView *)view{
    
    POPBasicAnimation* basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
    
    static int num = 0;
    //ziji jia
    num++;
    if (num>=4) {
        num=2;
    }
    
    
    basicAnimation.toValue = [NSNumber numberWithFloat:CGRectGetHeight(view.frame)/num];
    
    basicAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //    basicAnimation.duration = 3.f;
    
    [basicAnimation setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
        if (fin) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(view.frame));
            
            //            POPBasicAnimation* newBasic = [POPBasicAnimation easeInEaseOutAnimation];
            
            //            newBasic.property = [POPAnimatableProperty propertyWithName:kPOPLayerCornerRadius];
            
            //            newBasic.toValue = [NSNumber numberWithFloat:0];
            
            //            [view.layer pop_addAnimation:newBasic forKey:@"go"];
            
        }
        
    }];
    
    [view.layer pop_addAnimation:basicAnimation forKey:@"frameChange"];
}


//组合动画

-(void)group:(UIView *)view

{
    
    view.transform = CGAffineTransformMakeRotation(M_PI_2/3);
    
    
    
    
    
    POPBasicAnimation* spring = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    spring.beginTime = CACurrentMediaTime();
    
    spring.duration = .4f;
    
    spring.fromValue = [NSNumber numberWithFloat:-100.f];
    
    spring.toValue = [NSNumber numberWithFloat:CGRectGetMinY(view.frame) + 10];
    
    [spring setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
    }];
    
    
    
    
    
    POPBasicAnimation* basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    basic.beginTime = CACurrentMediaTime();
    
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    basic.toValue = [NSNumber numberWithFloat:-M_PI_4];
    
    basic.duration = .4f;
    
    
    
    
    
    POPBasicAnimation* rotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    rotation.beginTime = CACurrentMediaTime() + .4f;
    
    rotation.toValue = [NSNumber numberWithFloat:0.f];
    
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    rotation.duration = .25f;
    
    
    
    
    
    POPBasicAnimation* donw = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    donw.beginTime = CACurrentMediaTime() + 0.4f;
    
    donw.toValue = [NSNumber numberWithFloat:CGRectGetMinY(view.frame)];
    
    donw.duration = .25f;
    
    donw.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    
    
    
    
    
    
    [view.layer pop_addAnimation:spring forKey:@"spring"];
    
    [view.layer pop_addAnimation:basic forKey:@"basic"];
    
    [view.layer pop_addAnimation:donw forKey:@"down"];
    
    [view.layer pop_addAnimation:rotation forKey:@"rotation"];
    
}

@end
