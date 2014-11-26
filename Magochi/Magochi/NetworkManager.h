//
//  NetworkManager.h
//  Magochi
//
//  Created by Mario Silveira on 11/26/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "3rdPartyLibraries/AFNetworking/AFHTTPSessionManager.h"


@interface NetworkManager : AFHTTPSessionManager

+(NetworkManager*) sharedInstance ;
@end
