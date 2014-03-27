//
//  ListDetailViewController.m
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController {
    NSString *iconName;
}

@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checklistToEdit;
@synthesize iconImageView;



//Setting the image for the deafult
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        iconName = @"Folder";
    }
    return self;
}

//Setting the icon image so it appears beside the icon image

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    if (self.checklistToEdit != nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = self.checklistToEdit.iconName;
    }

    self.iconImageView.image = [UIImage imageNamed:iconName];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.translucent = YES;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
}


// The keyboard appears when the screen is opened
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [self.textField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//The cancel button
- (IBAction)cancel
{
    [self.delegate listDetailViewControllerDidCancel:self];
}


//The done button
- (IBAction)done
{
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.textField.text;
        checklist.iconName = iconName;

        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    } else {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = iconName;

        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}


//This method triggers the segue when the row is tapped on by the user
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

//UIDelegate method so when the user changes the text when the user uses the keyboard or copy and paste

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}


//This is to notify us when the user clicks on the PickIcon button
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
