//
//  CCNoteDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailsController.h"
#import "CCDefines.h"

@interface CCNoteDetailsController ()

@property (nonatomic, weak) IBOutlet UILabel *noteName;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@end

@implementation CCNoteDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.noteName.text = self.note.noteDescription;
    if(self.note.thumbnailRetina.length){
        NSURL *urlToThumbnail = [NSURL URLWithString:[CCAPIDefines.baseURL stringByAppendingString:self.note.thumbnailRetina]];
        [self.thumbnail setImageWithURL:urlToThumbnail];
    }
}

- (IBAction)viewPDFButtonDidPressed
{
    [self.viewNotesAsPDFTransaction performWithObject:self.note];
}

@end
