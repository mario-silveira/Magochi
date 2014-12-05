//
//  TestEjercicio.m
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Mascota.h"
#import "InstanciaMascota.h"
#import "CoreDataHelper.h"

@interface TestEjercicio : XCTestCase

@property Mascota* mascota;

@end

@implementation TestEjercicio

- (void)setUp {
    [super setUp];
    Mascota * mascota = (Mascota*)[NSEntityDescription insertNewObjectForEntityForName:@"Mascota"
                                                                inManagedObjectContext: [[CoreDataHelper sharedInstance] managedObjectContext]];
    mascota.nombre = @"Mascota test";
    mascota.codigo = @"MS8031";
    mascota.nivel = [[NSNumber alloc] initWithInt:1];
    mascota.energia = [[NSNumber alloc] initWithInt:100];
    mascota.experienciaSiguienteNivel = [[NSNumber alloc] initWithInt:100];
    mascota.experiencia = [[NSNumber alloc] initWithInt:0];
    
    
    [[InstanciaMascota sharedInstance] setMascota:mascota];
    self.mascota = mascota;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) test1Ejercicio {
    [[InstanciaMascota sharedInstance] tickTimerEjercicio];
    
    Mascota* m = [[InstanciaMascota sharedInstance] getMascota];
    XCTAssertTrue(m.energia.intValue == 90, @"Error en la energia");
}

-(void) test2Nivel {
    self.mascota.experiencia = [[NSNumber alloc]initWithInt:95];
    [[InstanciaMascota sharedInstance] tickTimerEjercicio];
    
    XCTAssertTrue(self.mascota.nivel.intValue == 2);
    XCTAssertTrue(self.mascota.experiencia.intValue == 10);

}



@end
