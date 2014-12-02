//
//  ViewControllerGameView.h
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Comida.h"
#import "ViewControllerTablaComidas.h"
#import "Mascota.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewControllerGameView : UIViewController <tableProtocol, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imgBoca;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesto;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;
@property Mascota* mascota;

@property (strong, nonatomic) IBOutlet UIProgressView *pgbEnergia;
@property (strong, nonatomic) IBOutlet UIButton *btnEjercicio;


-(ViewControllerGameView*) initWithData;
-(void) setComida: (Comida*) comida;

@end
