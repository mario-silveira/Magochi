//
//  TestServicios.m
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Mascota.h"
#import "CoreDataHelper.h"
#import "ServicioPostMascota.h"

@interface TestServicios : XCTestCase

@property Mascota* mascota;
@end

@implementation TestServicios

- (void)setUp {
    [super setUp];

    Mascota * mascota = (Mascota*)[NSEntityDescription insertNewObjectForEntityForName:@"Mascota"
                                                                inManagedObjectContext: [[CoreDataHelper sharedInstance] managedObjectContext]];
    mascota.codigo = @"MS8031";
    mascota.nombre = @"Mascota test service";
    mascota.nivel = [[NSNumber alloc] initWithInt:1];
    mascota.energia = [[NSNumber alloc] initWithInt:100];
    mascota.experienciaSiguienteNivel = [[NSNumber alloc] initWithInt:100];
    mascota.experiencia = [[NSNumber alloc] initWithInt:0];
    
    self.mascota = mascota;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) test1Post {
    XCTestExpectation* expectation = [self expectationWithDescription:@"test1Post"];
    ServicioPostMascota* post = [[ServicioPostMascota alloc] init];
    [post almacenarMascota:self.mascota bloque:^(bool result) {
        XCTAssertTrue(result, @"Error en el post");
        [expectation fulfill];
    }];
   [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
       if (error){
       NSLog(@"Post timeout");
        }
   }];
}



@end
