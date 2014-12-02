//
//  CellRanking.h
//  Magochi
//
//  Created by Mario Silveira on 11/29/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mascota.h"

@protocol mostrarMapaProtocol

-(void) mostrarMapa: (Mascota*) mascota;

@end

@interface CellRanking : UITableViewCell

@property (nonatomic, weak) id <mostrarMapaProtocol> delegate;

-(void) setData :(Mascota *) mascota;

@end
