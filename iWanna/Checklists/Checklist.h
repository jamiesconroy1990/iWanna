//
//  Checklist.h
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *iconName;
@property(nonatomic, retain) UIColor *barTintColor;

- (int)countUncheckedItems;

@end
