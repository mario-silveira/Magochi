//
//  ViewControllerContactos.h
//  Magochi
//
//  Created by Mario Silveira on 12/5/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellContacto.h"
#import <MessageUI/MessageUI.h>


@interface ViewControllerContactos : UIViewController <enviarLlamado, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblContactos;

@end
