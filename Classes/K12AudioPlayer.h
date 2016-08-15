//
//  K12AudioPlayer.h
//  K12
//
//  Created by stonedong on 16/3/6.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class K12AudioPlayer;
@protocol K12AudioPlayerDelegate <NSObject>
@optional
- (void) k12AudioPlayer:(K12AudioPlayer*)player playAtTimeOffset:(double)time;
- (void) k12AudioPlayer:(K12AudioPlayer *)player occurError:(NSError*)error;
- (void) k12AudioPlayerDidFinishPlay:(K12AudioPlayer *)player;
- (void) k12AudioPlayerDidStartPlay:(K12AudioPlayer *)player;
@end

@interface K12AudioPlayer : NSObject
@property (nonatomic, assign, readonly) NSTimeInterval duration;
@property (nonatomic, weak) id<K12AudioPlayerDelegate> delegate;
@property (nonatomic, strong, readonly) NSURL* url;
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign, readonly) NSTimeInterval playingTime;
- (instancetype) initWithURL:(NSURL*)url;
- (void) stop;
- (BOOL) play;
@end
