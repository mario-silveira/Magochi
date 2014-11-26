//
//  VCPruebasNetworking.m
//  Magochi
//
//  Created by Mario Silveira on 11/26/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "VCPruebasNetworking.h"
#import "NetworkManager.h"

@interface VCPruebasNetworking ()

@end

@implementation VCPruebasNetworking

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.txvTexto setEditable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnNetwork:(id)sender {
    [[NetworkManager sharedInstance] GET:@"/key/value/one/two" parameters:nil
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     NSLog(@"llega");
                                     
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     NSLog(@"error");
                                 }];
    
}





@end
