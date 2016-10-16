//
//  Created by merowing on 22/04/2014.
//
//
//


@import Foundation;
#import "KZBehavior.h"

//! Generates UIControlEventValueChanged when character limit is updated
@interface KZCharacterLimitBehaviour : KZBehavior <UITextViewDelegate>

//! used text view
@property(nonatomic, weak) IBOutlet UITextView *textView;

//! label used to display number of remaining characters
@property(nonatomic, weak) IBOutlet UILabel *counterLabel;

//! max count of characters allowed
@property(nonatomic, assign) IBInspectable NSUInteger maxCount;
@property(nonatomic, assign) IBInspectable BOOL hideKeyboardOnReturn;
@end