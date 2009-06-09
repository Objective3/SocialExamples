//
//  SocialExamplesViewController.m
//  SocialExamples
//
//  Created by Blake Watters on 6/9/09.
//  Copyright Objective 3 2009. All rights reserved.
//

#import "SocialExamplesViewController.h"
#import "FBStatusUpdateRequest.h"

@implementation SocialExamplesViewController

static NSString* kFacebookAPIKey = @"1ea674f8aef02e450cf1a4dadb5b160e";
static NSString* kFacebookAPISecret = @"965577a493d08559702323b927512f2e";
static double kFacebookTemplateBundleID = 89565091133;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupSharingSound];
	
	_session = [[FBSession sessionForApplication:kFacebookAPIKey secret:kFacebookAPISecret delegate:self] retain];
}

- (void)dealloc {
	// Sharing sound
	AudioServicesDisposeSystemSoundID(_soundFileObject);
	CFRelease(_soundFileURLRef);
	
	[_session logout];
	[_session release];
	
	[_twitterEngine release];
	
	[super dealloc];
}

#pragma mark Actions

- (IBAction)facebookButtonWasPressed:(id)sender {
	if (! [_session isConnected]) {
		FBLoginDialog* dialog = [[[FBLoginDialog alloc] initWithSession:_session] autorelease];
		[dialog show];
	} else {
		UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle: NSLocalizedString(@"Test Facebook", nil) 
														   delegate: self 
												  cancelButtonTitle: NSLocalizedString(@"Cancel", nil) 
											 destructiveButtonTitle: nil 
												  otherButtonTitles: NSLocalizedString(@"Post to Feed",nil), NSLocalizedString(@"Update Status", nil), nil];
		[sheet showInView:self.view];
		[sheet release];	
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 0){
		[self postToFacebook];
	} else if (buttonIndex == 1){
		[self setFacebookStatus];
	}
}

- (void)postToFacebook {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	FBFeedDialog* dialog = [[[FBFeedDialog alloc] init] autorelease];
	dialog.delegate = self;
	dialog.templateBundleId = kFacebookTemplateBundleID;
	dialog.templateData = @"{\"key1\": \"value1\"}";
	[dialog show];
}

- (void)setFacebookStatus {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	NSString* statusString = @"My status was updated from the iPhone!";
	[FBStatusUpdateRequest requestStatusUpdate:statusString delegate:self];
}

- (void)displayFacebookError:(NSError*)error {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Facebook Error", nil) message: [error localizedDescription] delegate:nil cancelButtonTitle: NSLocalizedString(@"Cancel", nil) otherButtonTitles: nil];
	[alert show];
	[alert release];
}

#pragma mark Sharing Sound

- (void)setupSharingSound {
	// Get the main bundle for the app
	CFBundleRef mainBundle;
	mainBundle = CFBundleGetMainBundle();
	
	// Get the URL to the sound file to play
	_soundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("Mail Sent"), CFSTR("aiff"), NULL);
	
	// Create a system sound object representing the sound file
	AudioServicesCreateSystemSoundID(_soundFileURLRef, &_soundFileObject);
}

- (void)playSharingSound {
	AudioServicesPlaySystemSound(_soundFileObject);
}

#pragma mark FBSessionDelegate Methods

- (void)session:(FBSession*)theSession didLogin:(FBUID)uid {
	NSString* alertString = [NSString stringWithFormat:@"Your Facebook UserID is %d", uid];
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Facebook Login", nil) message:alertString delegate:self cancelButtonTitle: NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
	[alert show];
	[alert release];
	NSLog(@"User with id %lld logged in.", uid);
	
	[_facebookButton setTitle:@"Post to Facebook" forState:UIControlStateNormal];	
}

- (void)sessionDidLogout:(FBSession*)session {
	NSLog(@"User has logged out of Facebook");
}

#pragma mark FBDialogDelegate

- (void)dialogDidSucceed:(FBDialog*)dialog {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self playSharingSound];
}

- (void)dialogDidCancel:(FBDialog*)dialog {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self displayFacebookError:error];
}

#pragma mark FBStatusUpdateRequestDelegate

- (void)statusUpdateRequestWasSuccessful:(FBStatusUpdateRequest*)statusUpdateRequest {
	NSLog(@"Successfully updated status to: %@", [statusUpdateRequest statusText]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self playSharingSound];
}

- (void)statusUpdateRequestFailed:(FBStatusUpdateRequest*)statusUpdateRequest {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Status Update Failed", nil) message: @"Dailypix was unable to update your Facebook status." delegate: nil cancelButtonTitle: NSLocalizedString(@"Cancel", nil) otherButtonTitles: nil];
	[alert show];
	[alert release];
}

- (void)statusUpdateRequest:(FBStatusUpdateRequest*)statusUpdateRequest didFailWithError:(NSError*)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self displayFacebookError:error];
}

#pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self facebookButtonWasPressed:self];
}

@end
