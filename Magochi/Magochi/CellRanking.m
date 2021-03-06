//
//  CellRanking.m
//  Magochi
//
//  Created by Mario Silveira on 11/29/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "CellRanking.h"
#import "InstanciaMascota.h"
#import "ViewControllerMapa.h"

@interface CellRanking ()

@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UILabel *lblNivel;
@property (strong, nonatomic) Mascota* mascota;

@end


@implementation CellRanking

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(Mascota *)mascota {
    [mascota setTipo: mascota.tipo];
    
    [self.imgMascota setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [mascota getImagenMascota]]]];
    [self.lblNivel setText:mascota.nivel.description];
    [self.lblNombre setText:mascota.nombre];
    
    if ([mascota.codigo isEqual:[[InstanciaMascota sharedInstance] getMascota].codigo]){
        [self setBackgroundColor:[UIColor greenColor]];
    } else {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    self.mascota = mascota;
    
}
- (IBAction)clickMap:(id)sender {
    [self.delegate mostrarMapa:self.mascota];
}

@end
