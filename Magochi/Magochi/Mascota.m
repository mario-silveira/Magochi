//
//  Mascota.m
//  Magochi
//
//  Created by Mario Silveira on 11/21/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "Mascota.h"

@implementation Mascota

-(Mascota*) init {
    Mascota* mascota = [super init];
    mascota.energia = [[NSNumber alloc]initWithInt:100];
    return mascota;
}


@end


