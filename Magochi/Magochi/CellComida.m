//
//  CellComida.m
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "CellComida.h"

@implementation CellComida

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setData :(Comida *) comida{
    self.lblComida.text = comida.nombreComida;
    self.imgComida.image = [UIImage imageNamed:comida.imagenComida];
    self.comida = comida;
}


@end
