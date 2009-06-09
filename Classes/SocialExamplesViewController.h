//
//  SocialExamplesViewController.h
//  SocialExamples
//
//  Created by Blake Watters on 6/9/09.
//  Copyright Objective 3 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

// Facebook support
#import "FBConnect/FBConnect.h"
#import "FBStatusUpdateRequest.h"

// Twitter support
#define USE_LIBXML 1
#import "MGTwitterEngine.h"

@interface SocialExamplesViewController : UIViewController <FBSessionDelegate, FBStatusUpdateRequestDelegate, FBDialogDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
	// Facebook
	FBSession* _session;
	
	// Twitter
	MGTwitterEngine* _twitterEngine;
	
	// Posting Sound
	CFURLRef		_soundFileURLRef;
	SystemSoundID	_soundFileObject;
	
	// Outlets
	IBOutlet UIButton* _facebookButton;
}

- (IBAction)facebookButtonWasPressed:(id)sender;
- (void)postToFacebook;
- (void)setFacebookStatus;
- (void)setupSharingSound;
- (void)playSharingSound;

@end
