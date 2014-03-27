//
//  AddItemViewController.m
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController {
    NSDate *dueDate;
}

@synthesize textField;
@synthesize doneBarButton;
@synthesize switchControl;
@synthesize dueDateLabel;
@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
    } else {
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
 
    [self updateDueDateLabel];
    
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
        self.navigationController.navigationBar.translucent = YES;
    }else {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    [self.textField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}

- (IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];
}
 
- (IBAction)done
{
    if (self.itemToEdit == nil) {
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        item.shouldRemind = self.switchControl.on;
        item.dueDate = dueDate;
        [item scheduleNotification];
 
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    } else {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        [self.itemToEdit scheduleNotification];
 
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return indexPath;
    } else {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
 
- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
 
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
