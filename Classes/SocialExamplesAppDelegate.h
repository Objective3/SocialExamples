//
//  SocialExamplesAppDelegate.h
//  SocialExamples
//
//  Created by Blake Watters on 6/9/09.
//  Copyright Objective 3 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialExamplesViewController;

@interface SocialExamplesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SocialExamplesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SocialExamplesViewController *viewController;

@end

