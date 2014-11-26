//
//  NetworkManager.m
//  Magochi
//
//  Created by Mario Silveira on 11/26/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "NetworkManager.h"
#import "3rdPartyLibraries/AFNetworking/AFHTTPSessionManager.h"
#import "3rdPartyLibraries/UIKit+AFNetworking/AFNetworkActivityIndicatorManager.h"
#import "InstanciaMascota.h"

//#import "AFNetworking-master/AFJSONRequestSerializer"

@implementation NetworkManager : AFHTTPSessionManager


+(NSDictionary*) getAdditionalHeaders {
    return [[NSDictionary alloc]init];
}


+(NetworkManager*) sharedInstance {
    
    static NetworkManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = [NetworkManager getAdditionalHeaders];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024     // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024     // 50MB. on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        sessionConfiguration.timeoutIntervalForRequest = 20,0;
        
        // Initialize the session
        _sharedInstance = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString: @"http://tamagotchi.herokuapp.com"] sessionConfiguration:sessionConfiguration];
        
        //Setup a default JSONSerializer for all request/responses.
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    
    return _sharedInstance;
}

@end


