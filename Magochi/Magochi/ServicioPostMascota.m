//
//  ServicioPostMascota.m
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ServicioPostMascota.h"
#import "NetworkManager.h"

@interface ServicioPostMascota ()

@property (nonatomic, copy) SuccessPostMascota successBlock;

@end

@implementation ServicioPostMascota



-(void) almacenarMascota:(Mascota *)mascota bloque:(SuccessPostMascota)successblock {
    self.successBlock = successblock;
    [[NetworkManager sharedInstance] POST:@"/pet"
                               parameters:[mascota dataForSending]
                                  success: [self successPostBlock]
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(error.localizedDescription);
                                  }];
}

-(void (^)(NSURLSessionDataTask *task, id responseObject)) successPostBlock {
    __weak typeof(self) weakSelf = self;
   return ^(NSURLSessionDataTask* task, id responseObject){
       
       if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok" ]) {
           NSLog(@"la info llego sin error");
           weakSelf.successBlock(true);
       } else {
           NSLog(@"hay errores en el llamado del post");
           weakSelf.successBlock(false);
       }
       
    };
    
}


@end
