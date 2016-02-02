//
//  Created by Marat Alekperov (aka Timur Harleev) (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THChatInput;
@protocol THChatInputDelegate <UITextViewDelegate>
- (void)chat:(THChatInput*)input sendWasPressed:(NSString*)text;
@optional
- (void)chatShowAttachInput:(THChatInput*)cinput;
- (void)chatShowEmojiInput:(THChatInput*)cinput;
- (void)chatUpdatedKeyboardProperties:(THChatInput*)cinput;
- (void)chatKeyboardWillShow:(THChatInput*)cinput;
- (void)chatKeyboardDidShow:(THChatInput*)cinput;
- (void)chatKeyboardWillHide:(THChatInput*)cinput;
- (void)chatKeyboardDidHide:(THChatInput*)cinput;
@end

@interface THChatInput : UIView <UITextViewDelegate>
{
    CGFloat topGap;
    CGFloat keyboardAnimationDuration;
    UIViewAnimationCurve keyboardAnimationCurve;
    CGFloat keyboardHeight;
    int inputHeight;
    int inputHeightWithShadow;
    BOOL autoResizeOnKeyboardVisibilityChanged;
}
@property (weak) IBOutlet id<THChatInputDelegate> delegate;

@property (strong, nonatomic) UIButton* sendButton;
@property (strong, nonatomic) UIButton* attachButton;
@property (strong, nonatomic) UIButton* emojiButton;
@property (strong, nonatomic) UITextView* textView;
@property (strong, nonatomic) UILabel* lblPlaceholder;
@property (strong, nonatomic) UIImageView* inputBackgroundView;
@property (strong, nonatomic) UITextField *textViewBackgroundView;

@property (readwrite, nonatomic) CGFloat keyboardHeight;

- (NSString*)text;
- (void)setText:(NSString*)text;
- (void)setPlaceholder:(NSString*)text;

@end
