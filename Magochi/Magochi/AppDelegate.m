//
//  AppDelegate.m
//  Magochi
//
//  Created by Mario Silveira on 11/18/14.
//  Copyright (c) 2014 Globant. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerDataEntry.h"
#import "ViewControllerGameView.h"
#import "ViewControllerImageGallery.h"
#import <Parse/Parse.h>
#import "Constantes.h"
#import "Utils.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
#else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
#endif

    
    
    
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD"
                  clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    
    
    UILocalNotification* localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICACION_NIVEL" object:nil userInfo:localNotification.userInfo];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController* view;
    [Utils cargarImagenes];
    
 /*   if ([[NSUserDefaults standardUserDefaults] boolForKey:NOMBRE_MASCOTA_CARGADO]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:IMAGEN_MASCOTA_CARGADA]) {
            view = [[ViewControllerGameView alloc]initWithData];
        } else {
            view = [[ViewControllerImageGallery alloc] initWithNibName:@"ViewControllerImageGallery" bundle:nil];
        }
    } else {*/
        view = [[ViewControllerDataEntry alloc] initWithNibName:@"ViewControllerDataEntry" bundle:nil];
    //}
    
    UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:view];
    
    [self.window setRootViewController:navControllerHome];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
  /*  [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICACION_NIVEL" object:nil userInfo:notification.userInfo];

    application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber - 1;
    NSLog(@"llego la notificacion local en fore");*/
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *instalation = [PFInstallation currentInstallation];
    [instalation addUniqueObject:@"PeleaDeMascotas" forKey:@"channels"];
    [instalation setDeviceTokenFromData:deviceToken];
    [instalation saveInBackground];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICACION_NIVEL" object:nil userInfo:userInfo];
}

@end
