//
//  K12AudionSession.h
//  K12
//
//  Created by stonedong on 16/3/6.
//  Copyright © 2016年 stonedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define K12AudioShareSession  [K12AudionSession shareSession]
#define K12AudioShareSessionBecomeAction [K12AudioShareSession becomeActive]
#define K12AudioShareSessionResignAction [K12AudioShareSession resignActive]

@interface K12AudionSession : NSObject
@property (nonatomic, readonly, assign) BOOL avavilable;
+ (instancetype) shareSession;
- (void) becomeActive;
- (void) resignActive;
@end
