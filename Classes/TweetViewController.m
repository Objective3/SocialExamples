//
//  TweetViewController.m
//  Thumbprint
//
//  Created by Jeremy Ellison on 5/28/09.
//  Copyright 2009 Objective3. All rights reserved.
//

#import "TweetViewController.h"

@implementation TweetViewController

@synthesize tweetString;
@synthesize delegate;

- (id)initWithTweetString:(NSString *)tweet delegate:(id)del{
	if (self = [super init]) {
		self.tweetString = tweet;
		self.delegate = del;
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[doneButton setEnabled:NO];
	
	titleLabel.text = [NSString stringWithFormat:@"Send Tweet"];
}

- (void)textViewDidChange:(UITextView *)textView {
	int count = 140 - [textView.text length];
	textCountLabel.text = [NSString stringWithFormat:@"%d characters left", count];
}

- (void)setTweet:(NSString *)tweet {
	[tweetTextView setText:tweet];
	[tweetTextView becomeFirstResponder];
	[self textViewDidChange:tweetTextView];
	[spinner stopAnimating];
	[doneButton setEnabled:YES];
}

- (void)viewDidAppear:(BOOL)animated {
	[self setTweet:tweetString];
}

- (IBAction)cancelButtonWasPressed:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneButtonWasPressed:(id)sender {
	[delegate sendTweetWithString:[tweetTextView text]];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.tweetString = nil;
	self.delegate = nil;
    [super dealloc];
}


@end
