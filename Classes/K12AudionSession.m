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
#import <Bugly/BuglyLog.h>
@implementation K12AudionSession
{
    AVAudioSession* _audioSession;
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
    _audioSession = [AVAudioSession sharedInstance];
    NSError* error=nil;
    [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    return self;
}

- (void) becomeActive
{
    NSError* error;
    [_audioSession setActive:YES error:&error];
    if (error) {
        BLYLogError(@"Audio Session Become Action error:%@", error);
    }

    
}
@end

