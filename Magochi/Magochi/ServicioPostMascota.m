//
//  ServicioPostMascota.m
//  Magochi
//
//  Created by Mario Silveira on 12/1/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ServicioPostMascota.h"
#import "NetworkManager.h"

@implementation ServicioPostMascota



-(void) almacenarMascota: (Mascota*) mascota{

    [[NetworkManager sharedInstance] POST:@"/pet"
                               parameters:[mascota dataForSending]
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                    //                  NSHTTPURLResponse* httpRsp = (NSHTTPURLResponse*) responseObject;
                                      if ([[responseObject objectForKey:@"status"] isEqualToString:@"ok"]){
                                          NSLog(@"la info llego sin error");
                                      } else {
                                          NSLog(@"hay errores en el llamado");
                                      }
                                      
                                      
                                  }
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(error.localizedDescription);
                                  }];

    
}
@end
