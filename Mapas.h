//
//  Mapas.h
//  lugareslab07
//
//  Created by Ricardo Vera on 19/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

//-----------------------------------------------------------------------------------------------------
//agregar para banner.<UIApplicationDelegate, ADBannerViewDelegate>

@interface Mapas : UIViewController<UIApplicationDelegate, ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
//---------------------------------------------------------------------------------------------------

//Actions.
- (IBAction)BtnInicio:(id)sender;
- (IBAction)BtnLista:(id)sender;
- (IBAction)BtnGoogleMaps:(id)sender;

@end
