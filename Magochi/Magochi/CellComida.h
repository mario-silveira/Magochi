//
//  CellComida.h
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comida.h"

@interface CellComida : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblComida;
@property (strong, nonatomic) IBOutlet UIImageView *imgComida;
@property Comida *comida;

-(void) setData :(Comida *) comida;

@end
