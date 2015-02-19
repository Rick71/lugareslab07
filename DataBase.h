//
//  DataBase.h
//  lugareslab07
//
//  Created by Ricardo Vera on 17/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <iAd/iAd.h>

//-----------------------------------------------------------------------------------------------------
//agregar para banner.<UIApplicationDelegate, ADBannerViewDelegate>

@interface DataBase : UIViewController<UIApplicationDelegate, ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
//-----------------------------------------------------------------------------------------------------

//Label
@property (strong, nonatomic) IBOutlet UILabel *LblTitulo;

//Text
@property (strong, nonatomic) IBOutlet UITextField *TxtNombre;
@property (strong, nonatomic) IBOutlet UITextField *TxtDescripcion;
@property (strong, nonatomic) IBOutlet UITextField *TxtLatitud;
@property (strong, nonatomic) IBOutlet UITextField *TxtLongitud;

//Buton Action
- (IBAction)BtnGuardar:(id)sender;
- (IBAction)BtnInicio:(id)sender;

@end
