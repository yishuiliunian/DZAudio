//
//  K12AudioRecorder.m
//  K12
//
//  Created by stonedong on 16/3/9.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import "K12AudioRecorder.h"
#import <DZFileUtils/DZFileUtils.h>
#import "K12AudionSession.h"
//#import <Bugly/Bugly.h>

@interface K12AudioRecorder () <AVAudioRecorderDelegate>

@end

@implementation K12AudioRecorder
{
    NSTimer* _timer;
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _audoFormat =kAudioFormatMPEG4AAC;
    return self;
}

- (BOOL) reload
{
    if (_recorder) {
        _recorder.delegate = nil;
        [_timer invalidate];
        _timer = nil;
        [_recorder stop];
        if ([[NSFileManager defaultManager] fileExistsAtPath:_recorder.url.path]) {
            [_recorder deleteRecording];
        }
    }
    K12AudioShareSessionBecomeAction;
    //配置Recorder，
    NSString* path = nil;
    NSMutableDictionary* recordSetting = [NSMutableDictionary new];
    if (_audoFormat == kAudioFormatLinearPCM) {
        path =DZTempFilePathWithExtension(@"caf");
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:16000] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    } else {
        path = DZTempFilePathWithExtension(@"aac");
        NSDictionary *rs = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                       [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                                       [NSNumber numberWithFloat:16000],AVSampleRateKey,
                                       [NSNumber numberWithInteger:_audoFormat], AVFormatIDKey,
                                       nil];
        [recordSetting addEntriesFromDictionary:rs];
    }
 
    NSError* error;

    _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:recordSetting error:&error];
    if (error) {
//        BLYLogError(@"初始化录音播放:%@",error);
    }

    _recorder.delegate = self;
    _recorder.meteringEnabled = YES;
   return  [_recorder prepareToRecord];
}

- (void) updateMeters
{
    if ([self.delegate respondsToSelector:@selector(k12AudioRecorder:recordingWithMeters:)]) {
        [_recorder updateMeters];
        double meters = [_recorder averagePowerForChannel:0];
        [self.delegate k12AudioRecorder:_recorder recordingWithMeters:meters];
    }
}

- (BOOL) record:(NSError*__autoreleasing * )error{
    [self stop];
    BOOL buildRecordRet= [self reload];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:error];
   return [_recorder record];
}
- (void) stop
{
    [_timer invalidate];
    _timer = nil;
    [_recorder stop];
}

- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(k12AudioRecorderEncodeErrorDidOccur:error:)]) {
        [self.delegate k12AudioRecorderEncodeErrorDidOccur:recorder error:error];
    }
    K12AudioShareSessionResignAction;
}


- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if ([self.delegate respondsToSelector:@selector(k12AudioRecorderDidFinishRecording:successfully:)]) {
        [self.delegate k12AudioRecorderDidFinishRecording:recorder successfully:flag];
    }
    K12AudioShareSessionResignAction;
}



@end
