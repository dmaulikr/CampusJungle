//
//  CCClassController.m
//  CampusJungle
//
//  Created by Yulia Petryshena on 6/5/13.
//  Copyright (c) 2013 111minutes. All rights reserved.
//

#import "CCClassController.h"
#import "CCClass.h"

@interface CCClassController ()
@property (nonatomic, strong) CCClass *currentClass;
@property (weak, nonatomic) IBOutlet UILabel *classNumber;
@property (weak, nonatomic) IBOutlet UILabel *professor;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation CCClassController

- (id)initWitchClass:(CCClass*)class
{
    self = [super init];
    if (self) {
        self.currentClass = class;
        [self.navigationItem setTitle:class.subject];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadInfo];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(editClass)];
}

- (void)loadInfo
{
    self.navigationController.navigationItem.title = self.currentClass.subject;
    self.professor.text = self.currentClass.professor;
    self.classNumber.text = self.currentClass.callNumber;
}

- (void)editClass
{
    
}
@end
