//
//  DataModel.h
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;
@property(nonatomic, retain) UIColor *barTintColor;

- (void)saveChecklists;
- (int)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(int)index;
- (void)sortChecklists;

+ (int)nextChecklistItemId;

@end
