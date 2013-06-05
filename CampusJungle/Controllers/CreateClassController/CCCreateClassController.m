//
//  CCCreateClassController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/4/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCCreateClassController.h"
#import "CCClass.h"
#import "CCClassesApiProviderProtocol.h"


@interface CCCreateClassController ()

@property (nonatomic, strong) NSString *collegeID;
@property (nonatomic, strong) id <CCClassesApiProviderProtocol> ioc_apiClassesProvider;
@property (weak, nonatomic) IBOutlet UITextField *subjectLabel;
@property (weak, nonatomic) IBOutlet UITextField *semesterLabel;
@property (weak, nonatomic) IBOutlet UITextField *professorLabel;
@property (weak, nonatomic) IBOutlet UITextField *classID;


@end

@implementation CCCreateClassController

- (id)initWithCollegeID:(NSString*)collegeID
{
self = [super init];
if (self) {
    self.collegeID = collegeID;
}
return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
}

- (IBAction)createClass:(id)sender {
    CCClass *class = [CCClass new];
    class.collegeID = self.collegeID;
    class.professor = self.professorLabel.text;
    class.subject = self.subjectLabel.text;
    class.semester = self.semesterLabel.text;
    class.callNumber = self.classID.text;
    class.timetable = @[@{@"day":@"Tue", @"time":@"23:00"}];
    
    [self.ioc_apiClassesProvider createClass:class successHandler:^(CCClass *newClass) {
        [self joinClass:class];
        
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)joinClass:(CCClass*)class
{
   [self.ioc_apiClassesProvider joinClass:class.classID SuccessHandler:^(id response) {
       
   } errorHandler:^(NSError *error) {
       
   }];
}

@end
