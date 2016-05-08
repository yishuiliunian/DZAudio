//
//  K12AudioRecorder.h
//  K12
//
//  Created by stonedong on 16/3/9.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class K12AudioRecorder;
@protocol K12AudioRecorderDelegate <NSObject>
@optional
- (void) k12AudioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error;
- (void) k12AudioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag;
- (void) k12AudioRecorder:(AVAudioRecorder *)recorder recordingWithMeters:(double)meters;
@end


@interface K12AudioRecorder : NSObject
@property (nonatomic, weak) id<K12AudioRecorderDelegate> delegate;
@property (nonatomic, strong, readonly) AVAudioRecorder* recorder;
- (BOOL) record:(NSError*__autoreleasing * )error;
- (void) stop;
@end
