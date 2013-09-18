// Copyright 2008-2013 Omni Development, Inc. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

#import <OmniBase/OmniBase.h>
#import <Foundation/Foundation.h>

// Common stuff we need from OmniFoundation
#import <OmniFoundation/OFNull.h>
#import <OmniFoundation/NSString-OFSimpleMatching.h>
#import <OmniFoundation/NSString-OFReplacement.h>
#import <OmniFoundation/NSDate-OFExtensions.h>

OB_HIDDEN NSInteger ODAVConnectionDebug;
#define DEBUG_DAV(level, format, ...) do { \
    if (ODAVConnectionDebug >= (level)) \
        NSLog(@"DAV %@: " format, [self shortDescription], ## __VA_ARGS__); \
    } while (0)

OB_HIDDEN NSInteger ODAVConnectionTaskDebug;
#define DEBUG_TASK(level, format, ...) do { \
    if (ODAVConnectionTaskDebug >= (level)) \
        NSLog(@"DAV TASK %@: " format, [self shortDescription], ## __VA_ARGS__); \
    } while (0)
