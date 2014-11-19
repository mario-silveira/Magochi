//
//  ViewControllerGameView.h
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerGameView : UIViewController

- (id)initWithData: (NSString*) nombre imagen: (NSString*) imagenMascota;
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UIImageView *imgMascota;

@end