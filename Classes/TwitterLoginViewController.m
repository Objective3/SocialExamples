//
//  TwitterLoginViewController.m
//  Thumbprint
//
//  Created by Blake Watters on 5/14/09.
//  Copyright 2009 Objective 3. All rights reserved.
//

#import "TwitterLoginViewController.h"

@implementation TwitterLoginViewController

@synthesize username;
@synthesize password;
@synthesize delegate;

- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)orientation {
	if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
		return NO;
	} else {
		return YES;
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	twitterEngine = [[MGTwitterEngine twitterEngineWithDelegate:self] retain];
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[usernameField becomeFirstResponder];
}


- (IBAction)loginButtonWasPressed:(id)sender
{
	NSLog(@"Login button was pressed!");
	[spinner startAnimating];
	username = [[usernameField text] retain];
	password = [[passwordField text] retain];
	NSLog(@"Attempting to login with %@/%@", username, password);
	[twitterEngine setUsername:username password:password];
	credentialsRequestIdentifier = [twitterEngine checkUserCredentials];
}


- (IBAction)cancelButtonWasPressed:(id)sender
{
	NSLog(@"Cancel button was pressed!");
	[twitterEngine setUsername:nil password:nil];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)dealloc
{
	[twitterEngine release];
	[username release];
	[password release];
    [super dealloc];
}

- (void)requestSucceeded:(NSString *)requestIdentifier
{
	NSLog(@"Got back a response on identifier %@", requestIdentifier);
	if (requestIdentifier == credentialsRequestIdentifier) {
		NSLog(@"request identifiers matched");
		[delegate performSelector:@selector(twitterLoginWasSuccessful)];
		[spinner stopAnimating];
		[self dismissModalViewControllerAnimated:YES];		
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self loginButtonWasPressed:nil];
	return YES;
}

- (void)requestFailed:(NSString *)requestIdentifier withError:(NSError *)error
{
	[spinner stopAnimating];
	if ([[error localizedDescription] isEqualToString:@"Operation could not be completed. (HTTP error 401.)"]) {
		[errorLabel setText:@"Unable to login. Please verify your credentials and try again."];
	} else {
		[errorLabel setText:[error localizedDescription]];
	}
	NSLog(@"Request failed for requestIdentifier = %@, error = %@ (%@)", 
          requestIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
	
	[errorLabel setHidden:NO];
}

@end
