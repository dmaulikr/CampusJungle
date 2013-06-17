//
//  CCNoteDetailsControllerViewController.m
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCNoteDetailsController.h"

@interface CCNoteDetailsController ()

@property (nonatomic, weak) IBOutlet UILabel *noteName;

@end

@implementation CCNoteDetailsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.noteName.text = self.note.noteDescription;
}


@end
