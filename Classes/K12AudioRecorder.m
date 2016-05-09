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
    return self;
}

- (BOOL) reload
{
    [K12AudionSession shareSession];
    if (_recorder) {
        _recorder.delegate = nil;
        [_timer invalidate];
        _timer = nil;
        [_recorder stop];
        [_recorder deleteRecording];
    }

    //配置Recorder，
    NSString* path = DZTempFilePathWithExtension(@"caf");
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   nil];
    NSError* error;
    K12AudioShareSessionBecomeAction;
    _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:path] settings:recordSetting error:&error];
    if (error) {
//        BLYLogError(@"初始化录音播放:%@",error);
    }

    _recorder.delegate = self;
    if (error) {
//        BLYLogError(@"%@",error);
    } else {

    }
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
   BOOL buildRecordRet= [self reload];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
//    BLYLogInfo(@"buildRecordRet %d",buildRecordRet);
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
}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
    if ([self.delegate respondsToSelector:@selector(k12AudioRecorderDidFinishRecording:successfully:)]) {
        [self.delegate k12AudioRecorderDidFinishRecording:recorder successfully:flag];
    }
}



@end
