//
//  NSTextView+Validation.h
//
//  Created by Trent Milton on 02/07/2014.
//  Copyright (c) 2014 shaydes.dsgn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
    TextViewValidationTypeNone=0, // Default
    TextViewValidationTypeRequired,
    TextViewValidationTypeOptional
} TextViewValidationType;

@interface NSTextView (Validation)

@property (nonatomic) TextViewValidationType textViewValidationType;

+ (void)setBackgroundColour:(NSColor *)colour;
+ (void)setValidBackgroundColour:(NSColor *)colour;
+ (void)setInvalidBackgroundColour:(NSColor *)colour;

- (BOOL) validate;
- (void) reset;

@end
