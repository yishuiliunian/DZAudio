//
//  K12AudionSession.m
//  K12
//
//  Created by stonedong on 16/3/6.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import "K12AudionSession.h"
#import "DZSingletonFactory.h"
#import <AVFoundation/AVFoundation.h>
#import <DZLogger/DZLogger.h>
@implementation K12AudionSession
{
}
+ (instancetype) shareSession
{
    return DZSingleForClass(self);
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    return self;
}

- (void) becomeActive
{
    NSError* error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (error) {
        DDLogError(@"%@",error);
    }
}
- (void) resignActive
{
    NSError* error;
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    if (error) {
        DDLogError(@"%@",error);
    }
}
@end

