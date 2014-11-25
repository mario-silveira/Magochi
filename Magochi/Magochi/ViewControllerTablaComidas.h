//
//  ViewControllerTablaComidas.h
//  Magochi
//
//  Created by Mario Silveira on 11/20/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comida.h"

@protocol tableProtocol

-(void) setearComida: (Comida*) comida;

@end

@interface ViewControllerTablaComidas : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <tableProtocol> delegate;

@end
