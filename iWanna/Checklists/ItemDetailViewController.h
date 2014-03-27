//
//  AddItemViewController.h
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;
@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;
@property (nonatomic, strong) IBOutlet UILabel *dueDateLabel;
@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) ChecklistItem *itemToEdit;
@property(nonatomic, retain) UIColor *barTintColor;

- (IBAction)cancel;
- (IBAction)done;

@end
