//
//  Annotation.h
//  Magochi
//
//  Created by Mario Silveira on 12/2/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface Anotacion : MKAnnotationView

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* subtitle;
@property (nonatomic, retain) UIImage* image;


@end
