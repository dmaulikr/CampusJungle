//
//  CCNotesViewerControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNotesViewerController.h"
#import "CCDefines.h"
#import "MBProgressHUD.h"

@interface CCNotesViewerController () <UIWebViewDelegate>

@property (nonatomic, weak)  IBOutlet UIWebView *pdfViewer;

@end

@implementation CCNotesViewerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPDF];
}

- (void)loadPDF
{
    NSString *noteURLStringRepresentation = [CCAPIDefines.baseURL stringByAppendingString: self.noteForDisplay.link];
    NSURL *noteURL = [NSURL URLWithString:noteURLStringRepresentation];
    NSURLRequest *requestForNote = [NSURLRequest requestWithURL:noteURL];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.pdfViewer loadRequest:requestForNote];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end