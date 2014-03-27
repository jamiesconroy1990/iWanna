//
//  IconPickerViewController.m
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController {
    NSArray *icons;
}
 
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


//Loads all of the icons into the app
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    icons = [NSArray arrayWithObjects:
        @"No Icon",
        @"Appointments",
        @"Birthdays",
        @"Chores",
        @"Drinks",
        @"Folder",
        @"Groceries",
        @"Inbox",
        @"Photos",
        @"Trips",
        nil];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.translucent = YES;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [icons count];
}

//This method triggers the segue when the row is tapped on by the user
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
 
    NSString *icon = [icons objectAtIndex:indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
