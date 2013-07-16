//
//  CCNoteDetailsControllerViewController.h
//  CampusJungle
//
//  Created by Vlad Korzun on 17.06.13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTableBaseViewController.h"
#import "CCNote.h"
#import "CCTransactionWithObject.h"
#import "CCTransaction.h"

@interface CCNoteDetailsController : CCTableBaseViewController

@property (nonatomic, strong) CCNote *note;
@property (nonatomic, strong) id <CCTransactionWithObject> viewNotesAsPDFTransaction;
@property (nonatomic, strong) id <CCTransaction> backToListTransaction;
@property (nonatomic, strong) id <CCTransactionWithObject> rateTransaction;

- (IBAction)viewPDFButtonDidPressed;

- (IBAction)buyForViewButtonPressed;

- (IBAction)buyForDownloadButtonPressed;

- (IBAction)resendLinkButtonDidPressed;

- (IBAction)removeNoteButtonDidPressed;

@end
