//
//  ViewController.h
//  lugareslab07
//
//  Created by Ricardo Vera on 17/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
//agregar para Banner.
#import <iAd/iAd.h>
#import "GAITrackedViewController.h"

//---------------------------------------------------------------------------------------------------
//al UIViewController agregar para banner.<UIApplicationDelegate, ADBannerViewDelegate>

@interface Index : GAITrackedViewController<UIApplicationDelegate, ADBannerViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
//---------------------------------------------------------------------------------------------------

//Actions
- (IBAction)BtnListaBares:(id)sender;
- (IBAction)BtnCrearRegistro:(id)sender;

@end

