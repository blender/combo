//
//  comboViewController.m
//  combo
//
//  Created by Tommaso Piazza on 6/30/11.
//  Copyright 2011 ChalmersTH. All rights reserved.
//

#import "comboViewController.h"

@implementation comboViewController

@synthesize webView = _webView, searchButton = _searchButton, textView = _textView, delegate = _delegate;
@synthesize connectButton = _connectButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([comboViewController isDeviceAniPad]){
        
        _webView.delegate = self;
        
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]isDirectory:NO]]];
        linkMode = 0;
    }
    else {
    
        // Start the Server
        
        sharedServerController = [ServerController sharedServerController];
        [sharedServerController startService];
        
        sharedServerController.delegate = self;
    
    
    }
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
//    NSURL *url = request.URL;
//    NSString *urlPath = url.query;
//    NSString *urlRelativePath = url.parameterString;
//    NSLog(urlPath);
//    NSLog(urlRelativePath);
    
    NSLog(@"%d", linkMode);
    
    if (linkMode == 0){
        return YES;
    }
    else { 
        
        [self jumpActionForPad:1];
    
        return NO;
    }
    
}

#pragma mark Link Actions

- (void) jumpActionForPad:(const int)padNumber{
    
    if(_delegate && [_delegate respondsToSelector:@selector(willSendMessageWihActionType: forPad: withAction:)]){
        
        [_delegate willSendMessageWihActionType:kActionTypeButton forPad:padNumber withAction:kActionJump];
        
    }
    
    
}

-(void) direction:(const int)direction forPad:(const int)pad{
    
    if(_delegate && [_delegate respondsToSelector:@selector(willSendMessageWihActionType: forPad: withAction:)]){
        
        [_delegate willSendMessageWihActionType:kActionTypeMove forPad:pad withAction:direction];
        
    }
    
}
#pragma mark Device Identification

+(BOOL)isDeviceAniPad {
    
#ifdef UI_USER_INTERFACE_IDIOM()
    return UI_USER_INTERFACE_IDIOM();
#else
    return NO;
#endif
}

#pragma mark Remote Mode

-(IBAction) searchForDevice:(id)sender{
    
   
    sharedClientController = [ClientController sharedClientController];
    _delegate = sharedClientController;
    sharedClientController.delegate = self;
    
    [[ClientController  sharedClientController] search];
    
}

- (IBAction) connectToDevice:(id)sender{
    
    linkMode = 1;

    NSMutableArray * services = [[ClientController sharedClientController] services];
    
    if([services count] > 0){
        
        
        [[ClientController sharedClientController] connectToService:[services objectAtIndex:0]];
    
    }
    else{
    
        [_connectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }

}

- (void) didFindService:(NSNetService *)aService{

    [_connectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
}

#pragma mark TBActionPassing Delegate

-(void) didReceiveMessageWithActionType:(int) msgActionType forPad:(int) padNumber withAction:(int) action{
    
    NSAssert(msgActionType == kActionTypeMove || msgActionType == kActionTypeButton, @"Pad Action unknown");
    
    
    if (msgActionType == kActionTypeButton){
        
        if(action == kActionJump)
            _textView.text = @"Rubaiat Habib Kazi, Kien-Chuan Chua, Shengdong Zhao, Richard C. Davis, Kok-Lim Low. 2011- to appear. SandCanvas: A Multi-touch Art Medium Inspired by Sand Animation.  In Proceedings of the 29th international conference on Human factors in computing systems. ACM, New York, NY, USA. 10 pages." ;   
    }else if(msgActionType == kActionTypeMove){
        
        _textView.text = @"Zhang, Haimo, and Shengdong Zhao. \"Measuring Web Page Revisitation in Tabbed Browsing.\" In Proc. of CHI2011, Vancouver, May 2011.";
        
    }
    
}


@end
