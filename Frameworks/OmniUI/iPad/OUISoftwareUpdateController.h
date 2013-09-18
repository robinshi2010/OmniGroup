// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

#import <Foundation/NSObject.h>
#import <OmniUI/OUIFeatures.h>

#if OUI_SOFTWARE_UPDATE_CHECK

#import "OUISoftwareUpdatePrivacyAlert.h"

@interface OUISoftwareUpdateController : NSObject <OUISoftwareUpdatePrivacyAlertDelegate>
{
@private
    OUISoftwareUpdatePrivacyAlert *_privacyAlert;
}
@end

#endif
