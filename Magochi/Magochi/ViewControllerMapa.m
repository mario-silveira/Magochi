//
//  ViewControllerMapa.m
//  Magochi
//
//  Created by Mario Silveira on 12/2/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "ViewControllerMapa.h"
#import "Anotacion.h"

@interface ViewControllerMapa ()

@end

@implementation ViewControllerMapa

-(ViewControllerMapa*) initWithData: (Mascota*) mascota{
    self = [super initWithNibName:@"ViewControllerMapa" bundle:nil];
    if (self) {
        self.mascota = mascota;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.lblNombre setText:self.mascota.nombre];
    MKCoordinateRegion region;
    region.center = self.mascota.ubicacion.coordinate;
    region.span.latitudeDelta = 0.02;
    region.span.longitudeDelta = 0.02;
    
    Anotacion* annotation = [[Anotacion alloc] init];
    [annotation setCoordinate:self.mascota.ubicacion.coordinate];
    [annotation setTitle:self.mascota.nombre];
    [annotation setSubtitle:self.mascota.nivel.description];

    
   
    
    [self.mpMapa addAnnotation:annotation];
    [self.mpMapa setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if (![annotation isKindOfClass:[Anotacion class]]) return nil;
    static NSString* ref = @"Anotacion";
    id an = [mapView dequeueReusableAnnotationViewWithIdentifier:ref];
    
    if (an == nil){
        an = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ref];
    //    [an setTitle:self.mascota.nombre];
        [an setCanShowCallout:YES];
        [an setImage:[UIImage imageNamed:self.mascota.getImagenMascota]];
    }
    return an;
}


@end
