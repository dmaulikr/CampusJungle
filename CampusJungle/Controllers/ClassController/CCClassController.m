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
#import "CCGroup.h"
#import "CCUserCell.h"
#import "CCClassTableController.h"
#import "GIAlert.h"
#import "CCClassesApiProviderProtocol.h"
#import "CCStandardErrorHandler.h"
#import "CCAlertHelper.h"
#import "CCButtonsHelper.h"
#import "CCVotesAPIProviderProtocol.h"

@interface CCClassController () <CCClassTableDelegate>

@property (nonatomic, weak) IBOutlet UILabel *classNumber;
@property (nonatomic, weak) IBOutlet UILabel *professor;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImage;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UILabel *semester;
@property (nonatomic, weak) IBOutlet UIImageView *classImage;

@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (nonatomic, weak) IBOutlet UIButton *feedbackButton;
@property (nonatomic, weak) IBOutlet UIButton *profUploadsButton;
@property (nonatomic, weak) IBOutlet UIButton *announcementButton;
@property (nonatomic, weak) IBOutlet UIButton *marketButton;
@property (nonatomic, weak) IBOutlet UIButton *timetableButton;

@property (nonatomic, strong) CCClassTableController *classContentTable;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_classesApiProvider;
@property (nonatomic, strong) id <CCVotesAPIProviderProtocol> ioc_votesApiProvider;

@property (nonatomic, strong) CCClass *currentClass;


- (IBAction)classFeedBackButtonDidPressed;

@end

@implementation CCClassController

- (id)initWithClass:(CCClass *)classObject
{
    self = [super init];
    if (self) {
        self.currentClass = classObject;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadInfo];
    [self setupButtons];
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setTitle:self.currentClass.className];
}

- (void)setupButtons
{
    [self setUpLeaveButton];
    [self setButtonsTextColorInView:self.headerView];
    
    [CCButtonsHelper removeBackgroundImageInButton:self.editButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.timetableButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.announcementButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.marketButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.profUploadsButton];
    [CCButtonsHelper removeBackgroundImageInButton:self.feedbackButton];
}

- (void)setupTableView
{
    self.classContentTable = [CCClassTableController new];
    self.classContentTable.tableHeaderView = self.headerView;
    self.classContentTable.classID = self.currentClass.classID;
    self.classContentTable.delegate = self;
    [self.view addSubview:self.classContentTable.view];
}

- (IBAction)classFeedBackButtonDidPressed
{
    
    if(self.currentClass.isProfessor.boolValue){
        [self.voteResultTransaction performWithObject:self.currentClass];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.ioc_votesApiProvider checkVoitingAvailabilityForClassWithID:self.currentClass.classID successHandler:^(RKMappingResult *response) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if([response.firstObject[@"availability"] boolValue]){
                [self.voteScreenTransaction performWithObject:self.currentClass];

            } else {
                [self.voteResultTransaction performWithObject:self.currentClass]; 
            }
        } errorHandler:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }
}

- (void)setUpLeaveButton
{
    UIImage *leaveClassImage = [UIImage imageNamed:@"leave_class_icon"];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, leaveClassImage.size.width  - 10, leaveClassImage.size.height - 10)];
    [button setImage:leaveClassImage forState:UIControlStateNormal];
    [CCButtonsHelper removeBackgroundImageInButton:button];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    [button addTarget:self action:@selector(leaveClassButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
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
    [self setTitle:self.currentClass.className];
    self.professor.text = [NSString stringWithFormat:@"Prof. %@", self.currentClass.professor];
    
    NSString *classId = [self.currentClass.callNumber length] > 0 ? self.currentClass.callNumber : @"unknown";
    self.classNumber.text = [NSString stringWithFormat:@"Class ID: %@", classId];
    NSString *semester = [self.currentClass.semester length] > 0 ? self.currentClass.semester : @"unknown";
    self.semester.text = [NSString stringWithFormat:@"Semester: %@", semester.capitalizedString];
    [self.classImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CCAPIDefines.baseURL,self.currentClass.classImageURL]] placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    self.title = self.currentClass.subject;
}

#pragma mark -
#pragma mark Actions
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
    [CCAlertHelper showWithMessage:@"Are you sure that you want to leave class?" success:^{
        [self.ioc_classesApiProvider leaveClassWithID:self.currentClass.classID SuccessHandler:^(id result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCNotificationsNames.reloadSideMenu object:nil];
            [self.newsFeedTransaction perform];
        } errorHandler:^(NSError *error) {
            [CCStandardErrorHandler showErrorWithError:error];
        }];
    }];
}

- (IBAction)timetableButtonDidPressed:(id)sender
{
    NSDictionary *paramsDictionary = @{@"class" : self.currentClass, @"controller" : self};
    [self.timetableTransaction performWithObject:paramsDictionary];
}

#pragma mark -
#pragma mark CCClassUpdateProtocol
- (void)updateWithClass:(CCClass *)updatedClass
{
    self.currentClass = updatedClass;
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

- (void)showDetailsOfGroup:(CCGroup *)group
{
    NSDictionary *params = @{@"group" : group, @"controller" : self};
    [self.groupDetailsTransaction performWithObject:params];
}

- (void)addLocation
{
    [self.addLocationTransaction performWithObject:self.currentClass];
}

- (void)addForum
{
    [self.addForumTransaction performWithObject:self.currentClass];
}

- (void)addGroup
{
    [self.addGroupTransaction performWithObject:self.currentClass];
}

- (void)sendInvite
{
    [self.sendInviteTransaction performWithObject:self.currentClass];
}

- (IBAction)professorUploadsButtonDidPressed
{
    [self.professorUploadsTransaction performWithObject:self.currentClass];
}

- (IBAction)announcementButtonDidPressed
{
    [self.announcementTransaction performWithObject:self.currentClass];
}

@end
