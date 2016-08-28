//
//  DZAudioManager.m
//  Pods
//
//  Created by stonedong on 16/7/23.
//
//

#import "DZAudioManager.h"
#import "K12AudioPlayer.h"
#import "K12AudionSession.h"
@interface DZAudioManager () <K12AudioPlayerDelegate>
@property (nonatomic, strong) K12AudioPlayer* player;
@end

@implementation DZAudioManager
 + (DZAudioManager*) shareManger
{
    static DZAudioManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DZAudioManager new];
    });
    return manager;
}

- (void) play:(NSURL *)url
{
    if (self.player) {
        [self.player stop];
    }
    K12AudioPlayer* player = [[K12AudioPlayer alloc] initWithURL:url];
    self.player = player;
    self.player.delegate = self;
    [self.player play];
}

- (void) k12AudioPlayer:(K12AudioPlayer *)player occurError:(NSError *)error
{
    
    self.player = nil;
    K12AudioShareSessionBecomeAction;
}

- (void) k12AudioPlayerDidFinishPlay:(K12AudioPlayer *)player
{
    self.player = nil;
    K12AudioShareSessionResignAction;
}

@end
