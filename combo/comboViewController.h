//
//  comboViewController.h
//  combo
//
//  Created by Tommaso Piazza on 6/30/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerController.h"
#import "TBActionPassingProtocolDelegate.h"
#import "ClientControllerProtocolDelegate.h"
#import "ClientController.h"

@interface comboViewController : UIViewController <UIWebViewDelegate, TBActionPassingProtocolDelegate, ClientControllerProtocolDelegate>{

    UIWebView *_webView;
    UITextView *_textView;
    UIButton *_searchButton;
    UIButton *_connectButton;
    ServerController *sharedServerController;
    ClientController *sharedClientController;
    id<TBActionPassingProtocolDelegate> _delegate;
    
    int linkMode;

}

+(BOOL)isDeviceAniPad; 

-(IBAction)searchForDevice:(id)sender;
-(IBAction)connectToDevice:(id)sender;

- (void) jumpActionForPad:(const int)padNumber;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *searchButton;
@property (nonatomic, retain) IBOutlet UIButton *connectButton;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, assign) id<TBActionPassingProtocolDelegate> delegate;

@end
