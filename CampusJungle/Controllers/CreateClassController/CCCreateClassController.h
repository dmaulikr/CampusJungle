//
//  CCCreateClassController.h
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCTransactionWithObject.h"
#import "CCTableBaseViewController.h"
#import "CCTimeTableDataProvider.h"
#import "CCClass.h"

@interface CCCreateClassController : CCTableBaseViewController

@property (nonatomic, strong) id <CCTransactionWithObject> classAddedTransaction;
@property (nonatomic, weak) IBOutlet UITextField *subjectTextField;
@property (nonatomic, weak) IBOutlet UITextField *semesterTextField;
@property (nonatomic, weak) IBOutlet UITextField *professorTextField;
@property (nonatomic, weak) IBOutlet UITextField *classIdTextField;
@property (nonatomic, weak) IBOutlet UITextField *classNameTextField;
@property (nonatomic, weak) IBOutlet UIImageView *thumbView;
@property (nonatomic, strong) CCTimeTableDataProvider *tableDataProvider;
@property (nonatomic) BOOL isAvatarUpdated;
@property (nonatomic, strong) NSString *collegeId;
- (IBAction)createClass:(id)sender;
- (id)initWithCollegeID:(NSString *)collegeId;
- (BOOL)isFormValid;
- (CCClass *)prepareClass;

@end
