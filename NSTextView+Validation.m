//
//  NSTextView+Validation.m
//
//  Created by Trent Milton on 02/07/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import "NSTextView+Validation.h"
#import <objc/runtime.h>

static NSColor *kValidationTextViewBackgroundColour;
static NSColor *kValidationTextViewValidBackgroundColour;
static NSColor *kValidationTextViewInvalidBackgroundColour;

static void *TextViewValidationTypePropertyKey = &TextViewValidationTypePropertyKey;
static void *PlaceholderStringPropertyKey = &PlaceholderStringPropertyKey;

@implementation NSTextView (Validation)

+ (void)initialize
{
	if (self == [NSTextView class]) {
		kValidationTextViewBackgroundColour = [NSColor whiteColor];
		kValidationTextViewValidBackgroundColour = [NSColor greenColor];
		kValidationTextViewInvalidBackgroundColour = [NSColor redColor];
	}
}

#pragma mark - Properties

- (TextViewValidationType)textViewValidationType
{
	NSNumber *t = objc_getAssociatedObject(self, TextViewValidationTypePropertyKey);
	return t.intValue;
}

- (void)setTextViewValidationType:(TextViewValidationType)textViewalidationType
{
	objc_setAssociatedObject(self, TextViewValidationTypePropertyKey, @(textViewalidationType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (BOOL)validate
{
	NSColor *bgColour = kValidationTextViewBackgroundColour;

	BOOL valid = YES;
	switch (self.textViewValidationType) {
		case TextViewValidationTypeNone:
			break;

		case TextViewValidationTypeRequired:
		default: {
			valid = self.string.length > 0;
			bgColour = valid ? kValidationTextViewValidBackgroundColour : kValidationTextViewInvalidBackgroundColour;
			break;
		}
	}

	self.backgroundColor = bgColour;
	// This will make sure the background updates
	[self setEditable:NO];
	[self setEditable:YES];

	return valid;
}

- (void)reset
{
	self.string = @"";
	self.backgroundColor = kValidationTextViewBackgroundColour;

	// This will make sure the background updates
	[self setEditable:NO];
	[self setEditable:YES];
}

#pragma mark - Static Properties

+ (void)setBackgroundColour:(NSColor *)colour
{
	kValidationTextViewBackgroundColour = colour;
}

+ (void)setValidBackgroundColour:(NSColor *)colour
{
	kValidationTextViewValidBackgroundColour = colour;
}

+ (void)setInvalidBackgroundColour:(NSColor *)colour
{
	kValidationTextViewInvalidBackgroundColour = colour;
}

@end
