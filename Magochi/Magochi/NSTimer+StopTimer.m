//
//  NSTimer+StopTimer.m
//  Magochi
//
//  Created by Mario Silveira on 11/25/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "NSTimer+StopTimer.h"

@implementation NSTimer (StopTimer)

-(void) pararTimer{
    if (self && [self isValid]){
        [self invalidate];
    }
    
}

@end
