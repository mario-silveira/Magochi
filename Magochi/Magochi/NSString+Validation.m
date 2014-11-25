//
//  NSString+Validation.m
//  Magochi
//
//  Created by Mario Silveira on 11/25/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isEmpty {
    return [self isEqualToString:@""];
}

- (BOOL) hasOnlyLetters {
    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    strCharSet = [strCharSet invertedSet];
    
    NSRange r = [self rangeOfCharacterFromSet:strCharSet];
    if (r.location != NSNotFound) {
        return NO;
    }
    return YES;
}

@end
