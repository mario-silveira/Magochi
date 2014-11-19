//
//  ViewControllerImageGallery.h
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerImageGallery : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong,nonatomic) NSString * nombreMascota;

- (id)initWithName: (NSString*) name;
@end
