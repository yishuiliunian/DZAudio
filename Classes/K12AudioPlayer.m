//
//  K12AudioPlayer.m
//  K12
//
//  Created by stonedong on 16/3/6.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import "K12AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "DZFileUtils.h"
#import "K12AudionSession.h"
@interface K12AudioPlayer () <AVAudioPlayerDelegate>
{
    AVAudioPlayer* _player;
    NSTimer* _playTimer;
}
@end

@implementation K12AudioPlayer
@synthesize delegate = _delegate;
- (void) dealloc
{
    
}
- (instancetype) initWithURL:(NSURL*)url
{
    self = [super init];
    if (!self) {
        return self;
    }
    [K12AudioShareSession becomeActive];
    _isPlaying = NO;
    _url = url;
    NSError* error;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_url error:&error];
    if (error) {
//        BLYLogError(@"初始化播放音频出错:%@",error);
    }
    _player.delegate = self;
    return self;
}

- (void) stop
{
    [_player stop];
    [_playTimer invalidate];
    _playTimer = nil;
    _isPlaying = NO;

}

- (BOOL) play
{
    [self stop];
 
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    if (![_player prepareToPlay]) return NO;
    if(![_player play]) return NO;
    
    _playTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(playCallBack) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_playTimer forMode:NSRunLoopCommonModes];
    [_playTimer fire];
    _isPlaying = YES;
    if ([self.delegate respondsToSelector:@selector(k12AudioPlayerDidStartPlay:)]) {
        [self.delegate k12AudioPlayerDidStartPlay:self];
    }
    return YES;
}
- (void) playCallBack
{
    if ([self.delegate respondsToSelector:@selector(k12AudioPlayer:playAtTimeOffset:)]) {
        [self.delegate k12AudioPlayer:self playAtTimeOffset:_player.currentTime];
    }
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        if ([self.delegate respondsToSelector:@selector(k12AudioPlayerDidFinishPlay:)]) {
            [self.delegate k12AudioPlayerDidFinishPlay:self];
        }
    }
}

- (NSTimeInterval) playingTime
{
    return _player.currentTime;
}
- (NSTimeInterval) duration
{
    return [_player duration];
}


@end
