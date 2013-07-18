//
//  CCClassController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassController.h"
#import "CCClass.h"
#import "CCLocation.h"
#import "CCClassmatesDataProvider.h"
#import "CCUserCell.h"
#import "CCClassTableController.h"
#import "GIAlert.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"

@interface CCClassController () <CCClassTableDelegate>

@property (nonatomic, weak) IBOutlet UILabel *classNumber;
@property (nonatomic, weak) IBOutlet UILabel *professor;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, strong) CCClassTableController *classContentTable;
@property (nonatomic, strong) id<CCClassesApiProviderProtocol> ioc_classesApiProvider;
@property (nonatomic, weak) IBOutlet UITextView *timeTable;
@property (nonatomic, weak) IBOutlet UIImageView *classImage;

@property (nonatomic, strong) CCClass *currentClass;

- (IBAction)editButtonDidPressed;

@end

@implementation CCClassController

- (id)initWithClass:(CCClass *)classObject
{
    self = [super init];
    if (self) {
        self.currentClass = classObject;
        [self.navigationItem setTitle:classObject.subject];
    }
    return self;
}

- (void)updateWithClass:(CCClass *)updatedClass
{
    self.currentClass = updatedClass;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInfo];
    [self setRightNavigationItemWithTitle:@"Leave class" selector:@selector(leaveClassButtonDidPress)];
    [self setButtonsTextColorInView:self.headerView];
    CCClassmatesDataProvider *classmateDataprovider = [CCClassmatesDataProvider new];
    classmateDataprovider.classID = self.currentClass.classID;
   
    self.classContentTable = [CCClassTableController new];
    self.classContentTable.tableHeaderView = self.headerView;
    self.classContentTable.classID = self.currentClass.classID;
    self.classContentTable.delegate = self;
    [self.view addSubview:self.classContentTable.view];
}

- (void)fillTimeTable
{
    NSString *timeTableString = @"";
    for(NSDictionary *time in self.currentClass.timetable){
        NSString *lessonRepresentation = [NSString stringWithFormat:@"%@ %@",time[@"day"],time[@"time"]];
        if(timeTableString.length){
            timeTableString = [timeTableString stringByAppendingFormat:@"\n%@",lessonRepresentation];
        } else {
            timeTableString = lessonRepresentation;
        }
    }
    self.timeTable.text = timeTableString;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.classContentTable viewWillAppear:animated];
    [self loadInfo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.classContentTable viewWillDisappear:animated];
}

- (void)loadInfo
{
    self.navigationController.navigationItem.title = self.currentClass.subject;
    self.professor.text = self.currentClass.professor;
    self.classNumber.text = self.currentClass.callNumber;
    [self.classImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.currentClass.classImageURL]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    [self fillTimeTable];
    self.title = self.currentClass.subject;
}

- (IBAction)editButtonDidPressed
{
    [self editClass];
}


- (void)editClass
{
    [self.editClassTransaction performWithObject:self.currentClass];
}

- (IBAction)classMarketButtonDidPressed
{
    [self.classMarketTransaction performWithObject:self.currentClass];
}

- (BOOL)isNeedToLeftSelected
{
    return NO;
}

- (IBAction)leaveClassButtonDidPress
{
    [CCAlertHelper showConfirmWithSuccess:^{
        [self.ioc_classesApiProvider leaveClassWithID:self.currentClass.classID SuccessHandler:^(id result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
            [self.newsFeedTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

#pragma mark -
#pragma mark ClassTableDelegate
- (void)showProfileOfUser:(CCUser *)user
{
    [self.otherUserProfileTransaction performWithObject:user];
}

- (void)showLocation:(CCLocation *)location onMapWithLocations:(NSArray *)locationsArray
{
    NSString *searchString = ([self.classContentTable.searchBar.text length] > 0) ? self.classContentTable.searchBar.text : @"";
    [self.locationTransaction performWithObject:@{@"location" : location, @"array" : locationsArray, @"class" : self.currentClass, @"searchString" : searchString}];
}

- (void)showDetailsOfForum:(CCForum *)forum
{
    [self.forumDetailsTransaction performWithObject:forum];
}

- (void)addLocation
{
    [self.addLocationTransaction performWithObject:self.currentClass];
}

- (void)addForum
{
    [self.addForumTransaction performWithObject:self.currentClass];
}


@end
