//
//  TwitterLoginViewController.h
//  Thumbprint
//
//  Created by Blake Watters on 5/14/09.
//  Copyright 2009 Objective 3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTwitterEngine.h"

@interface TwitterLoginViewController : UIViewController <UINavigationBarDelegate> {
	IBOutlet UIButton* loginButton;
	IBOutlet UIButton* cancelButton;
	IBOutlet UIActivityIndicatorView* spinner;
	IBOutlet UITextField* usernameField;
	IBOutlet UITextField* passwordField;
	IBOutlet UILabel* errorLabel;
	
	MGTwitterEngine* twitterEngine;
	NSString* credentialsRequestIdentifier;
	
	NSString* username;
	NSString* password;
	
	id delegate;
}

@property (nonatomic, retain, readonly) NSString* username;
@property (nonatomic, retain, readonly) NSString* password;
@property (nonatomic, assign) id delegate;

-(IBAction)loginButtonWasPressed:(id)sender;
-(IBAction)cancelButtonWasPressed:(id)sender;

@end
