//
//  CellContacto.m
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "CellContacto.h"

@interface CellContacto ()

@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UILabel *lblTrabajo;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblTelefono;

@property (strong, nonatomic) Contacto* contacto;
@property (strong, nonatomic) IBOutlet UIButton *btnEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnTel;

@end

@implementation CellContacto

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setData:(Contacto *)contacto {
    [self.lblNombre setText:contacto.nombre];
    [self.lblTrabajo setText:contacto.trabajo];
    [self.lblEmail setText:contacto.email];
    [self.lblTelefono setText:contacto.telefono];
    
    if ((!contacto.email) || contacto.email.length == 0) {
        [self.btnEmail setEnabled:NO];
        [self.btnEmail setAlpha:0];
    } else {
        [self.btnEmail setEnabled:YES];
        [self.btnEmail setAlpha:1.0];
    }
    
    if ((!contacto.telefono) || (contacto.telefono.length == 0)) {
        [self.btnTel setEnabled:NO];
        [self.btnTel setAlpha:0];
    } else {
        [self.btnTel setEnabled:YES];
        [self.btnTel setAlpha:1.0];
    }
    
    [self setContacto:contacto];
}
- (IBAction)clickEmail:(id)sender {
    [self.delegate enviarEmail:self.contacto.email];
}
- (IBAction)clickTelefono:(id)sender {
    [self.delegate llamarContacto:self.contacto.telefono];
}

@end
