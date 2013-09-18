// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

#import <UIKit/UIScrollView.h>
#import <OmniFoundation/OFExtent.h>

@class OUIScalingScrollView;

@protocol OUIScallingScrollViewDelegate <UIScrollViewDelegate>

@required
- (CGRect)scallingScrollViewContentViewFullScreenBounds:(OUIScalingScrollView *)scallingScrollView;

@end

@interface OUIScalingScrollView : UIScrollView

@property(nonatomic) OFExtent allowedEffectiveScaleExtent;
@property(nonatomic) BOOL centerContent;
@property(nonatomic) UIEdgeInsets extraEdgeInsets;

@property (nonatomic, assign) id<OUIScallingScrollViewDelegate> delegate;  // We'd like this to be weak, but the superclass declares it 'assign'.

- (CGFloat)fullScreenScaleForCanvasSize:(CGSize)canvasSize;

- (void)adjustScaleTo:(CGFloat)effectiveScale canvasSize:(CGSize)canvasSize;
- (void)adjustContentInsetAnimated:(BOOL)animated;

@end
