//
//  SocialExamplesAppDelegate.m
//  SocialExamples
//
//  Created by Blake Watters on 6/9/09.
//  Copyright Objective 3 2009. All rights reserved.
//

#import "SocialExamplesAppDelegate.h"
#import "SocialExamplesViewController.h"

@implementation SocialExamplesAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
