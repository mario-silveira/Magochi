//
//  Comida.h
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

@interface Comida  : NSObject


@property (strong,nonatomic) NSNumber * idComida;
@property (strong,nonatomic) NSString * nombreComida;
@property (strong,nonatomic) NSString * imagenComida;
@property (strong,nonatomic) NSNumber * valor;

-(id) initWithData: (NSNumber*) identifier : (NSString*) nombre : (NSString*) imagen;

@end

