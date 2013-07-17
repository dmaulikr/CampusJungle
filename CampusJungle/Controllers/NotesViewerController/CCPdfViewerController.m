//
//  CCPdfViewerController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 09.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCPdfViewerController.h"
#import "CCDefines.h"
#import "MBProgressHUD.h"

@interface CCPdfViewerController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *pdfViewer;
@property (nonatomic, strong) NSString *pdfUrlString;

@end

@implementation CCPdfViewerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"PDF Viewer";
    [self loadPDF];
}

- (void)loadPDF
{
    NSString *noteURLStringRepresentation = [CCAPIDefines.baseURL stringByAppendingString:self.pdfUrlString];
    NSURL *noteURL = [NSURL URLWithString:noteURLStringRepresentation];
    NSURLRequest *requestForNote = [NSURLRequest requestWithURL:noteURL];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.pdfViewer loadRequest:requestForNote];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self turnOffSelectionInWebView:webView];
}

- (void)turnOffSelectionInWebView:(UIWebView *)webView
{
    for (UIView *view in webView.subviews){
        if([view.subviews.lastObject isKindOfClass:NSClassFromString(@"UIWebPDFView")]){
            UIView *pdfViewer = view.subviews.lastObject;
            pdfViewer.userInteractionEnabled = NO;
        }
    }
}

@end