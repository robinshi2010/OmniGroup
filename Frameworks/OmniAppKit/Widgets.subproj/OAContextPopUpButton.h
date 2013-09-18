// Copyright 2004-2005, 2007, 2013 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

#import <AppKit/NSPopUpButton.h>


@interface OAContextPopUpButton : NSPopUpButton
{
    NSMenuItem *gearItem;
    id _delegate;
}

@property (nonatomic,assign) IBOutlet id delegate;
- (NSMenu *)locateActionMenu;
- (BOOL)validate;

@end
