//
//  ViewControllerDetalles.h
//  Magochi
//
//  Created by Mario Silveira on 12/4/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerDetalles : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblDetalle;

-(void) setCodigo: (NSString*) codigo;

@end
