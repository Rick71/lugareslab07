//
//  MuestraDB.h
//  lugareslab07
//
//  Created by Ricardo Vera on 18/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MuestraDB : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

//Buttons
- (IBAction)BtnInicio:(id)sender;
- (IBAction)BtnMapa:(id)sender;
- (IBAction)BtnRefresh:(id)sender;

//Images

//Labels

//Tablet
@property (strong, nonatomic) IBOutlet UITableView *TblMain;

//Views


//Actions


@end
