//
// Copyright 2011-2012 Adar Porat (https://github.com/aporat)
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "SOOAuth2ViewController.h"

@implementation SOOAuth2ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSHTTPCookieStorage *cookieStorage;
    
    cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies =  [cookieStorage cookies];
    
    for (NSHTTPCookie *cookie in cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    
    self.initialHTMLString = @"<html><body bgcolor=white><div align=center style='font-family:Arial'>Loading sign-in page...</div></body></html>";
    
    self.title = [NSString stringWithFormat:NSLocalizedString(@"Login to %@", @""), self.accountType.accountTypeDescription];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(pushIndexView)];
    
    CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [self.activityIndicator sizeToFit];
    self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewDidStartLoad)
                                                 name:kGTMOAuth2WebViewStartedLoading object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewDidFinishLoad)
                                                 name:kGTMOAuth2WebViewStoppedLoading object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidStartLoad {
    [self.activityIndicator startAnimating];
}

- (void)viewDidFinishLoad {
    [self.activityIndicator stopAnimating];
}

- (void)pushIndexView {
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
