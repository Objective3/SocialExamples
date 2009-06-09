//
//  TweetViewController.h
//  Thumbprint
//
//  Created by Jeremy Ellison on 5/28/09.
//  Copyright 2009 Objective3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGTwitterEngine.h"

@protocol TweetViewControllerDelegate

- (void)sendTweetWithString:(NSString *)tweet;

@end

@interface TweetViewController : UIViewController {
	NSString *tweetString;
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UIBarButtonItem *doneButton;
	IBOutlet UITextView *tweetTextView;
	IBOutlet UILabel *textCountLabel;
	IBOutlet UILabel *titleLabel;
	
	id delegate;
}
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString *tweetString;

- (id)initWithTweetString:(NSString *)tweet delegate:(id)del;
- (IBAction)cancelButtonWasPressed:(id)sender;
- (IBAction)doneButtonWasPressed:(id)sender;

@end