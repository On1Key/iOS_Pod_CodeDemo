//
//  XibModel.m
//  RSA
//
//  Created by mac book on 16/7/14.
//  Copyright © 2016年 mac book. All rights reserved.
//

#import "XibModel.h"

@implementation XibModel
+ (NSArray *)testModels{
    
    NSArray *headers = @[@"06.png",
                         @"01.PNG",
                         @"02.PNG",
                         @"3GTan.png",
                         @"04.PNG",
                         @"05,PNG"];
    NSArray *infoUrls = @[@"adas",
                          @"asdas",
                          @"2.jpg",
                          @"3.jpg",
                          @"4.jpg",
                          @"5.png",
                          @"cc.jpg"];
    NSArray *arrows = @[@"arrows@3x.png",
                        @"arrow_right@3x.png"];
    NSArray *infos = @[@"阿萨德法师打发阿萨德法师打发阿萨德爱上大法师的发送到发送到大发送到发送到发送到发的说法阿斯顿发生的发生阿凡达发送。",
                       @"adsfasd asdfasdfasdf asdfasd asdfasdfasdfasdfasdfasdfasdfasdfasdgdagadafdsSDFfSFASDFASDFSDAsdfvcvxczcvbxcndfgjdtyityjm xfghdfghdgfh dfghd fghsfgsdfgadag。",
                       @"21345566457689  65768965624534242545  4556765856787  347546856785679  45y567467867 24575678563rtur765956856 35684568567788656。",
                       @"家具的时刻啥都看监控345678432312·312453的思考数据库李经理阿达sdgfsdfhdfghfgasdfasdfasd阿萨德法师打发斯蒂芬阿萨德法师打发斯蒂芬阿斯达发送到发送到发送阿斯达发送到发送到发送到发送到发送到发送到发送到sddfSDHFJHGFa35764867564354253645736853746暗杀的发挥双方公司该敬爱嘎多哈尔套呵呵啥地方噶地方噶地方噶阿尔法告诉对方感到爱上大概SDG点噶啥的噶啥的阿萨德噶啥的。",
                       @"政府不收费爱上对方啊12123123qweqweq。"];
    NSArray *names = @[@"Jim",
                       @"Anderson",
                       @"William",
                       @"Duct",
                       @"Tom"];
    
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < 10; i ++) {
        XibModel *model = [XibModel new];
        model.headerUrl = headers[arc4random()%6];
        model.name = names[arc4random()%5];
        model.info = infos[arc4random()%5];
        model.infoUrl = infoUrls[arc4random()%5];
        model.arrow = arrows[arc4random()%2];
        [models addObject:model];
    }
    return models;
}
@end
