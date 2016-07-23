//
//  DZAudioManager.h
//  Pods
//
//  Created by stonedong on 16/7/23.
//
//

#import <Foundation/Foundation.h>

@interface DZAudioManager : NSObject
+ (DZAudioManager*) shareManger;
- (void) play:(NSURL*)url;
@end
