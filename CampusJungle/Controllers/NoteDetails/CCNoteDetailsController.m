//
//  CCNoteDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailsController.h"
#import "CCDefines.h"
#import "CCNotesAPIProviderProtolcol.h"
#import "CCStandardErrorHandler.h"

@interface CCNoteDetailsController ()

@property (nonatomic, weak) IBOutlet UILabel *noteName;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@property (nonatomic, weak) IBOutlet UIButton *fullAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *viewOnlyAccessButton;
@property (nonatomic, weak) IBOutlet UIButton *pdfButton;

@property (nonatomic, strong) id <CCNotesAPIProviderProtolcol> ioc_notesAPIProvider;

@end

@implementation CCNoteDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNotesInfo];
}

- (void)setUpNotesInfo
{
    self.noteName.text = self.note.noteDescription;
    if(self.note.thumbnailRetina.length){
        NSURL *urlToThumbnail = [NSURL URLWithString:[CCAPIDefines.baseURL stringByAppendingString:self.note.thumbnailRetina]];
        [self.thumbnail setImageWithURL:urlToThumbnail];
    }
    if(self.note.fullAccess){
        [self.viewOnlyAccessButton setHidden:YES];
        if([self.note.fullAccess isEqualToString:@"true"]){
            [self.fullAccessButton setHidden:YES];
        }
    } else {
        [self.pdfButton setHidden:YES];
    }

    NSString *viewOnlyTitle = [NSString stringWithFormat:@"Buy for view:%@",self.note];

    [self.viewOnlyAccessButton setTitle:viewOnlyTitle forState:UIControlStateNormal];

    NSString *fullAccessTitle = [NSString stringWithFormat:@"Buy for download:%@",self.note.fullPrice];
    [self.fullAccessButton setTitle:fullAccessTitle forState:UIControlStateNormal];
}

- (IBAction)viewPDFButtonDidPressed
{
    [self.ioc_notesAPIProvider fetchAttachmentURLForNoteWithID:self.note.noteID successHandler:^(id result){
        self.note.link = result[@"link"];
        [self.viewNotesAsPDFTransaction performWithObject:self.note];
    } errorHandler:^(NSError *error){
        [CCStandardErrorHandler showErrorWithError:error];
    }];
}

@end
