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
@property (weak, nonatomic) IBOutlet UITextView *timeTable;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation CCClassController

- (id)initWitchClass:(CCClass*)class
{
    self = [super init];
    if (self) {
        self.currentClass = class;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationItem.title = self.currentClass.subject;
    self.professor.text = self.currentClass.professor;
    self.classNumber.text = self.currentClass.callNumber;
}
@end
