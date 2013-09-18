// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniUI/OUIEmptyOverlayView.h>

#import "OUIParameters.h"

RCS_ID(")$Id$");

@interface OUIEmptyOverlayView ()

@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UIButton *button;

@end

@implementation OUIEmptyOverlayView
{
    void (^_action)(void);
    BOOL _permanentConstraintsAdded;
}

+ (instancetype)overlayViewWithMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle action:(void (^)(void))action;
{
    static UINib *nib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nib = [UINib nibWithNibName:@"OUIEmptyOverlayView" bundle:OMNI_BUNDLE];
    });
    
    OBASSERT_NOTNULL(nib);
    NSArray *topLevelObjects = [nib instantiateWithOwner:nil options:nil];
    
    OBASSERT(topLevelObjects.count == 1);
    OBASSERT([topLevelObjects[0] isKindOfClass:[self class]]);
    
    OUIEmptyOverlayView *view = topLevelObjects[0];
    [view _setUpWithMessage:message buttonTitle:buttonTitle action:action];
    
    return view;
}

- (void)_setUpWithMessage:(NSString *)message buttonTitle:(NSString *)buttonTitle action:(void (^)(void))action;
{
    OBASSERT_NOTNULL(_messageLabel);
    _messageLabel.text = message;
    _messageLabel.preferredMaxLayoutWidth = kOUIEmptyOverlayViewMessagePreferredMaxLayoutWidth;
    _messageLabel.textColor = [UIColor colorWithWhite:0.502 alpha:0.750];
    
    OBASSERT_NOTNULL(_button);
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [_button addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
#if 0 && defined(DEBUG_jake)
    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    _messageLabel.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.4];
    _button.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
#endif
    
    _action = action;
}

#pragma mark - Helpers
- (void)_buttonTapped:(id)sender;
{
    if (_action) {
        _action();
    }
}

@end
