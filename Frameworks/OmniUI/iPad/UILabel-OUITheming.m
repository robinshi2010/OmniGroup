// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniUI/UILabel-OUITheming.h>

#import <OmniUI/OUIInspectorWell.h>
#import <OmniUI/OUIDrawing.h>

RCS_ID("$Id$");

@implementation UILabel (OUITheming)

- (void)applyStyle:(OUILabelStyle)style;
{
    self.opaque = NO;
    self.backgroundColor = nil;

    switch (style) {
        case OUILabelStyleInspectorSliceGroupHeading:
            self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
            break;
            
        case OUILabelStyleInspectorSliceInstructionText:
            self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
            break;
            
        default:
            OBASSERT_NOT_REACHED("Invalid OUILabelStyle.");
            break;
    }
}

@end
