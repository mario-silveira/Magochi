//
//  ViewControllerMapa.h
//  Magochi
//
//  Created by Mario Silveira on 12/2/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Mascota.h"


@interface ViewControllerMapa : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mpMapa;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) Mascota* mascota;


-(ViewControllerMapa*) initWithData: (Mascota*) mascota;

@end
