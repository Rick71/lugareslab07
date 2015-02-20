//
//  Mapas.h
//  lugareslab07
//
//  Created by Ricardo Vera on 19/02/15.
//  Copyright (c) 2015 Comercomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>
#import "GAITrackedViewController.h"

//-----------------------------------------------------------------------------------------------------
//agregar para banner.<UIApplicationDelegate, ADBannerViewDelegate>

@interface Mapas : GAITrackedViewController<UIApplicationDelegate, ADBannerViewDelegate, CLLocationManagerDelegate, GMSMapViewDelegate>
{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}
//---------------------------------------------------------------------------------------------------

//Actions.
- (IBAction)BtnInicio:(id)sender;
- (IBAction)BtnLista:(id)sender;
- (IBAction)BtnGoogleMaps:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *Mapa;
@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;

@end
