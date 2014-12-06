//
//  CellContacto.h
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacto.h"

@protocol enviarLlamado

-(void) llamarContacto :(NSString*) telefono;
-(void) enviarEmail: (NSString*) email;

@end

@interface CellContacto : UITableViewCell

@property (nonatomic, weak) id <enviarLlamado> delegate;

-(void) setData :(Contacto*) contacto;

@end
