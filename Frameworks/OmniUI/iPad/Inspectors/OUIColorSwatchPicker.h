// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Id$

#import <UIKit/UIScrollView.h>

@class OQColor;

// A few built-in palette preference keys (in OmniUI.defaults)
extern NSString * const OUIColorSwatchPickerTextBackgroundPalettePreferenceKey;
extern NSString * const OUIColorSwatchPickerTextColorPalettePreferenceKey;

@interface OUIColorSwatchPicker : UIView

@property(copy,nonatomic) NSString *palettePreferenceKey;

@property(copy,nonatomic) NSArray *colors;
@property(strong,nonatomic) OQColor *color; // Simple cover for 'colors' when using a single color

@property(weak,nonatomic) id target; // We'll send -changeColor: (or to changeDetails: if showsSingleSwatch or if tap is on navigation swatch) to this when swatches are tapped

@property(assign,nonatomic) BOOL showsSingleSwatch; // If set, the entire view area shows just the first color and navigation to the detail is enabled.
@property(assign,nonatomic) BOOL wraps; // If set, and there are more than one row's worth of colors, wrap to following rows
@property(assign,nonatomic) BOOL showsNoneSwatch; // If set, the first swatch is reserved for a nil color value
@property(assign,nonatomic) BOOL showsNavigationSwatch; // If set, the last swatch is reserved for the detail color picker

- (void)sizeHeightToFit;

- (BOOL)hasMatchForColor:(OQColor *)color;
- (void)setSwatchSelectionColor:(OQColor *)color;
@property(readonly) BOOL hasSelectedSwatch;
- (void)addColor:(OQColor *)color replacingRecentlyAdded:(BOOL)replacingRecentlyAdded;

@end
