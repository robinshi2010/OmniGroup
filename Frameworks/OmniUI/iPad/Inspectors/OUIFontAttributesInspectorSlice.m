// Copyright 2010-2013 The Omni Group. All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.

#import <OmniUI/OUIFontAttributesInspectorSlice.h>

#import <OmniUI/OUIFontUtilities.h>
#import <OmniUI/OUISegmentedControl.h>
#import <OmniUI/OUISegmentedControlButton.h>
#import <OmniUI/OUIInspector.h>
#import <OmniAppKit/OAFontDescriptor.h>

RCS_ID("$Id$");

@implementation OUIFontAttributesInspectorSlice
{
    OUISegmentedControl *_fontAttributeSegmentedControl;
    OUISegmentedControlButton *_boldFontAttributeButton;
    OUISegmentedControlButton *_italicFontAttributeButton;
    OUISegmentedControlButton *_underlineFontAttributeButton;
    OUISegmentedControlButton *_strikethroughFontAttributeButton;
}

- (OUISegmentedControlButton *)fontAttributeButtonForType:(OUIFontAttributeButtonType)type; // Useful when overriding -updateFontAttributeButtons
{
    OUISegmentedControlButton *button = nil;
    
    switch (type) {
        case OUIFontAttributeButtonTypeBold:
            button = _boldFontAttributeButton;
            break;
        case OUIFontAttributeButtonTypeItalic:
            button = _italicFontAttributeButton;
            break;
        case OUIFontAttributeButtonTypeUnderline:
            button = _underlineFontAttributeButton;
            break;
        case OUIFontAttributeButtonTypeStrikethrough:
            button = _strikethroughFontAttributeButton;
            break;
        default:
            break;
    }
    
    return button;
}

- (void)updateFontAttributeButtonsWithFontDescriptors:(NSArray *)fontDescriptors;
{
    BOOL bold = NO, italic = NO;
    for (OAFontDescriptor *fontDescriptor in fontDescriptors) {
        bold |= [fontDescriptor bold];
        italic |= [fontDescriptor italic];
    }
    
    [_boldFontAttributeButton setSelected:bold];
    [_italicFontAttributeButton setSelected:italic];
    
    BOOL underline = NO, strikethrough = NO;
    for (id <OUIFontInspection> object in self.appropriateObjectsForInspection) {
        if ([object underlineStyleForInspectorSlice:self] != NSUnderlineStyleNone)
            underline = YES;
        if (_showStrikethrough) {
            if ([object strikethroughStyleForInspectorSlice:self] != NSUnderlineStyleNone)
                strikethrough = YES;
        }
    }
    [_underlineFontAttributeButton setSelected:underline];
    [_strikethroughFontAttributeButton setSelected:strikethrough];
}

#pragma mark - UIViewController subclass;

- (void)loadView;
{
    _fontAttributeSegmentedControl = [[OUISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 100, [OUISegmentedControl buttonHeight])];
    
    _fontAttributeSegmentedControl.sizesSegmentsToFit = YES;
    _fontAttributeSegmentedControl.allowsMultipleSelection = YES;
    
    _boldFontAttributeButton = [_fontAttributeSegmentedControl addSegmentWithImageNamed:@"OUIFontStyle-Bold.png"];
    [_boldFontAttributeButton addTarget:self action:@selector(_toggleBold:)];
    _boldFontAttributeButton.accessibilityLabel = NSLocalizedStringFromTableInBundle(@"Bold", @"OmniUI", OMNI_BUNDLE, @"Bold button accessibility label");
    
    
    _italicFontAttributeButton = [_fontAttributeSegmentedControl addSegmentWithImageNamed:@"OUIFontStyle-Italic.png"];
    [_italicFontAttributeButton addTarget:self action:@selector(_toggleItalic:)];
    _italicFontAttributeButton.accessibilityLabel = NSLocalizedStringFromTableInBundle(@"Italic", @"OmniUI", OMNI_BUNDLE, @"Italic button accessibility label");
    
    _underlineFontAttributeButton = [_fontAttributeSegmentedControl addSegmentWithImageNamed:@"OUIFontStyle-Underline.png"];
    [_underlineFontAttributeButton addTarget:self action:@selector(_toggleUnderline:)];
    _underlineFontAttributeButton.accessibilityLabel = NSLocalizedStringFromTableInBundle(@"Underline", @"OmniUI", OMNI_BUNDLE, @"Underline button accessibility label");
    
    if (_showStrikethrough) {
        _strikethroughFontAttributeButton = [_fontAttributeSegmentedControl addSegmentWithImageNamed:@"OUIFontStyle-Strikethrough.png"];
        [_strikethroughFontAttributeButton addTarget:self action:@selector(_toggleStrikethrough:)];
        _strikethroughFontAttributeButton.accessibilityLabel = NSLocalizedStringFromTableInBundle(@"Strike Through", @"OmniUI", OMNI_BUNDLE, @"Strike Through button accessibility label");
    }
    
    self.view = _fontAttributeSegmentedControl;
}

#pragma mark - OUIInspectorSlice subclass

- (BOOL)isAppropriateForInspectedObject:(id)object;
{
    return [object shouldBeInspectedByInspectorSlice:self protocol:@protocol(OUIFontInspection)];
}

- (void)updateInterfaceFromInspectedObjects:(OUIInspectorUpdateReason)reason;
{
    [super updateInterfaceFromInspectedObjects:reason];
    
    OUIFontSelection *selection = OUICollectFontSelection(self, self.appropriateObjectsForInspection);

    [self updateFontAttributeButtonsWithFontDescriptors:selection.fontDescriptors];
}

#pragma mark - Private

static id <OUIFontInspection> _firstFont(OUIFontAttributesInspectorSlice *self)
{
    NSArray *inspectedFonts = self.appropriateObjectsForInspection;
    if ([inspectedFonts count] == 0)
        return nil;
    
    return [inspectedFonts objectAtIndex:0];
}

static BOOL _toggledFlagToAssign(OUIFontAttributesInspectorSlice *self, SEL sel)
{
    id <OUIFontInspection> firstFont = _firstFont(self);
    if (!firstFont)
        return NO;
    
    OAFontDescriptor *desc = [firstFont fontDescriptorForInspectorSlice:self];
    
    BOOL (*getter)(id obj, SEL _cmd) = (typeof(getter))[desc methodForSelector:sel];
    OBASSERT(getter); // not checking the type...
    
    return !getter(desc, sel);
}

- (void)_toggleBold:(id)sender;
{
    [self.inspector willBeginChangingInspectedObjects];
    {
        BOOL flag = _toggledFlagToAssign(self, @selector(bold));
        
        for (id <OUIFontInspection> object in self.appropriateObjectsForInspection) {
            OAFontDescriptor *desc = [object fontDescriptorForInspectorSlice:self];
            desc = [desc newFontDescriptorWithBold:flag];
            [object setFontDescriptor:desc fromInspectorSlice:self];
        }
    }
    [self.inspector didEndChangingInspectedObjects];
}
- (void)_toggleItalic:(id)sender;
{
    [self.inspector willBeginChangingInspectedObjects];
    {
        BOOL flag = _toggledFlagToAssign(self, @selector(italic));
        
        for (id <OUIFontInspection> object in self.appropriateObjectsForInspection) {
            OAFontDescriptor *desc = [object fontDescriptorForInspectorSlice:self];
            desc = [desc newFontDescriptorWithItalic:flag];
            [object setFontDescriptor:desc fromInspectorSlice:self];
        }
    }
    [self.inspector didEndChangingInspectedObjects];
}
- (void)_toggleUnderline:(id)sender;
{
    [self.inspector willBeginChangingInspectedObjects];
    {
        id <OUIFontInspection> font = _firstFont(self);
        NSUnderlineStyle underline = [font underlineStyleForInspectorSlice:self];
        underline = (underline == NSUnderlineStyleNone) ? NSUnderlineStyleSingle : NSUnderlineStyleNone; // Press and hold for menu someday?
        
        for (id <OUIFontInspection> object in self.appropriateObjectsForInspection)
            [object setUnderlineStyle:underline fromInspectorSlice:self];
    }
    [self.inspector didEndChangingInspectedObjects];
}
- (void)_toggleStrikethrough:(id)sender;
{
    [self.inspector willBeginChangingInspectedObjects];
    {
        id <OUIFontInspection> font = _firstFont(self);
        NSUnderlineStyle strikethrough = [font strikethroughStyleForInspectorSlice:self];
        strikethrough = (strikethrough == NSUnderlineStyleNone) ? NSUnderlineStyleSingle : NSUnderlineStyleNone; // Press and hold for menu someday?
        
        for (id <OUIFontInspection> object in self.appropriateObjectsForInspection)
            [object setStrikethroughStyle:strikethrough fromInspectorSlice:self];
    }
    [self.inspector didEndChangingInspectedObjects];
}

@end
