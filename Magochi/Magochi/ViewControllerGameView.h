//
//  ViewControllerGameView.h
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comida.h"
#import "ViewControllerTablaComidas.h"

@interface ViewControllerGameView : UIViewController <tableProtocol>

- (id)initWithData: (NSString*) nombre imagen: (NSString*) imagenMascota;
-(void) setComida: (Comida*) comida;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;



@end
