//
//  ViewControllerRanking.h
//  Magochi
//
//  Created by Mario Silveira on 11/29/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellRanking.h"

@interface ViewControllerRanking : UIViewController <UITableViewDataSource, mostrarMapaProtocol>
@property (strong, nonatomic) IBOutlet UITableView *tblRanking;



@end
