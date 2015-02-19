//
//  GoogleMaps.h
//  lugareslab07
//
//  Created by Ricardo Vera on 19/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

//-----------------------------------------------------------------------------------------------------
//agregar para banner.<UIApplicationDelegate, ADBannerViewDelegate>

@interface GoogleMaps : UIViewController<UIApplicationDelegate, ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
//-----------------------------------------------------------------------------------------------------


//Labels

//Actions
- (IBAction)BtnInicio:(id)sender;
- (IBAction)BtnMapas:(id)sender;
- (IBAction)BtnLista:(id)sender;

@end
