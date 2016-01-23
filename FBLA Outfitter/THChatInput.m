//
//  Created by Marat Alekperov (aka Timur Harleev) (m.alekperov@gmail.com) on 18.11.12.
//  Copyright (c) 2012 Me and Myself. All rights reserved.
//


#import "THChatInput.h"

@interface NSString (THChatInput)
@end

@implementation NSString (THChatInput)

- (CGSize) sizeForFont:(UIFont *)font
{
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary* attribs = @{NSFontAttributeName:font};
        return ([self sizeWithAttributes:attribs]);
    }
    return ([self sizeWithFont:font]);
}

- (CGSize) sizeForFont:(UIFont*)font
        constrainedToSize:(CGSize)constraint
            lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        NSDictionary *attributes = @{NSFontAttributeName:font};
        
        CGSize boundingBox = [self boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        size = [self sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
    }
    
    return size;
}

@end

@implementation THChatInput
@synthesize inputBackgroundView;
@synthesize textViewBackgroundView;
@synthesize textView;
@synthesize lblPlaceholder;
@synthesize attachButton;
@synthesize emojiButton;
@synthesize sendButton;

@synthesize keyboardHeight;

static BOOL isIos7;

+ (BOOL)isIOS7
{
    return isIos7;
}

- (void) composeView
{
    isIos7 = [[[UIDevice currentDevice] systemVersion] floatValue]>=7;
    keyboardAnimationDuration = 0.25f;
    self.keyboardHeight = 216;
    topGap = isIos7 ? 8 : 12;
   
    inputHeight = 38.0f;
    inputHeightWithShadow = 44.0f;
    autoResizeOnKeyboardVisibilityChanged = NO;
    
    CGSize size = self.frame.size;
   
	self.inputBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
	inputBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    inputBackgroundView.contentMode = UIViewContentModeScaleToFill;
    inputBackgroundView.backgroundColor = [UIColor clearColor];
	[self addSubview:inputBackgroundView];
   
    self.textViewBackgroundView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    textViewBackgroundView.borderStyle = UITextBorderStyleRoundedRect;
	textViewBackgroundView.autoresizingMask = UIViewAutoresizingNone;
    textViewBackgroundView.userInteractionEnabled = NO;
    textViewBackgroundView.enabled = NO;
	[self addSubview:textViewBackgroundView];
    
	self.textView = [[UITextView alloc] initWithFrame:CGRectMake(70.0f, topGap, 185, 0)];
    textView.backgroundColor = [UIColor clearColor];
	textView.delegate = self;
    textView.contentInset = UIEdgeInsetsMake(-4, -2, -4, 0);
    textView.showsVerticalScrollIndicator = NO;
    textView.showsHorizontalScrollIndicator = NO;
    textView.returnKeyType = UIReturnKeySend;
	textView.font = [UIFont systemFontOfSize:15.0f];
	[self addSubview:textView];
   
   [self adjustTextInputHeightForText:@"" animated:NO];
   
    self.lblPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(78.0f, topGap+2, 160, 20)];
    lblPlaceholder.font = [UIFont systemFontOfSize:15.0f];
    lblPlaceholder.text = @"Caption your photo...";
    lblPlaceholder.textColor = [UIColor lightGrayColor];
    lblPlaceholder.backgroundColor = [UIColor clearColor];
	[self addSubview:lblPlaceholder];
   
	self.attachButton = [UIButton buttonWithType:UIButtonTypeCustom];
    attachButton.hidden = YES;
	attachButton.frame = CGRectMake(6.0f, topGap, 26.0f, 27.0f);
	attachButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [attachButton addTarget:self action:@selector(showAttachInput:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:attachButton];
	
	self.emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
	emojiButton.frame = CGRectMake(12.0f + attachButton.frame.size.width, topGap, 26.0f, 27.0f);
    emojiButton.hidden = YES;
	emojiButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [emojiButton addTarget:self action:@selector(showEmojiInput:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:emojiButton];
	
	self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
	sendButton.frame = CGRectMake(size.width - 64.0f, 12.0f, 58.0f, 27.0f);
    sendButton.hidden = YES;
	sendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:sendButton];
   
   [self sendSubviewToBack:inputBackgroundView];
    
    if (isIos7)
    {
        self.backgroundColor = [UIColor colorWithRed:(0xD9 / 255.0) green:(0xDC / 255.0) blue:(0xE0 / 255.0) alpha:1.0];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
        inputBackgroundView.image = [[UIImage imageNamed:@"Chat_Footer_BG.png"] stretchableImageWithLeftCapWidth:80 topCapHeight:25];
        
        [sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button.png"] forState:UIControlStateNormal];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateHighlighted];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"Chat_Send_Button_Pressed.png"] forState:UIControlStateSelected];
        [sendButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        [sendButton.titleLabel setShadowOffset:CGSizeMake(0.0f, 1.0f)];
        [sendButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [sendButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    
	[attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp.png"] forState:UIControlStateNormal];
	[attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateHighlighted];
	[attachButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_ArrowUp_Pressed.png"] forState:UIControlStateSelected];
    
	[emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon.png"] forState:UIControlStateNormal];
	[emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateHighlighted];
	[emojiButton setBackgroundImage:[UIImage imageNamed:@"Chat_Footer_Smiley_Icon_Pressed.png"] forState:UIControlStateSelected];
    
	[sendButton setTitle:@"Send" forState:UIControlStateNormal];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 70;
    CGFloat w = self.frame.size.width - attachButton.frame.size.width - emojiButton.frame.size.width - 10 - (sendButton.hidden ? 0 : (sendButton.frame.size.width+12+3));
    CGFloat d = 0;
    if (attachButton.hidden) { d = attachButton.frame.size.width; }
    else d = 0;
    x = x - d; w = w + d;
    if (emojiButton.hidden) { d = emojiButton.frame.size.width; }
    else d = 0;
    x = x - d; w = w + d;
    
    if (attachButton.hidden && emojiButton.hidden)
        x = 5;
    
    textView.frame = CGRectMake(x, textView.frame.origin.y, w, textView.frame.size.height);
    CGRect f = textView.frame;
    f.size.height = f.size.height+(isIos7?3:0);
    textViewBackgroundView.frame = f;
    lblPlaceholder.frame = CGRectMake(x+8, topGap+2, 160, 20);
    
    sendButton.frame = CGRectMake(sendButton.frame.origin.x,topGap,sendButton.frame.size.width,sendButton.frame.size.height);
}

- (void) awakeFromNib
{
   [self composeView];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview == nil)
    {
        [self listenForKeyboardNotifications:NO];
    }
    else
    {
        [self listenForKeyboardNotifications:YES];
    }
}

- (void) adjustTextInputHeightForText:(NSString*)text animated:(BOOL)animated
{
   int h1 = [text sizeForFont:textView.font].height;
   int h2 = [text sizeForFont:textView.font constrainedToSize:CGSizeMake(textView.frame.size.width - 16, 170.0f) lineBreakMode:NSLineBreakByWordWrapping].height;
   
   [UIView animateWithDuration:(animated ? .1f : 0) animations:^
    {
       int h = h2 == h1 ? inputHeightWithShadow : h2 + 24;
       int delta = h - self.frame.size.height;
       CGRect r2 = CGRectMake(0, self.frame.origin.y - delta, self.frame.size.width, h);
       self.frame = r2;
       inputBackgroundView.frame = CGRectMake(0, 0, self.frame.size.width, h);
       
       CGRect r = textView.frame;
       r.origin.y = topGap;
       r.size.height = h - 18;
       textView.frame = r;
       
    } completion:^(BOOL finished){ }];
}

- (id) initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   
   if (self)
   {
      [self composeView];
   }
   return self;
}

- (void) fitText
{
   [self adjustTextInputHeightForText:textView.text animated:YES];
}

- (BOOL)resignFirstResponder
{
    if (super.isFirstResponder)
        return [super resignFirstResponder];
    else if ([textView isFirstResponder])
        return [textView resignFirstResponder];
    return NO;
}

#pragma mark - Public Methods

- (NSString*)text
{
    return textView.text;
}

- (void) setText:(NSString*)text
{
    textView.text = text;
    lblPlaceholder.hidden = text.length > 0;
    [self fitText];
}

- (void) setPlaceholder:(NSString*)text
{
    lblPlaceholder.text = text;
}

#pragma mark - Display

- (void)beganEditing
{
    if (autoResizeOnKeyboardVisibilityChanged)
    {
        UIViewAnimationOptions opt = animationOptionsWithCurve(keyboardAnimationCurve);

        [UIView animateWithDuration:keyboardAnimationDuration delay:0 options:opt animations:^
        {
             self.transform = CGAffineTransformMakeTranslation(0, -self.keyboardHeight);
        } completion:^(BOOL fin){}];
        [self fitText];
    }
}

- (void)endedEditing
{
    if (autoResizeOnKeyboardVisibilityChanged)
    {
        UIViewAnimationOptions opt = animationOptionsWithCurve(keyboardAnimationCurve);
        
        [UIView animateWithDuration:keyboardAnimationDuration delay:0 options:opt animations:^
         {
             self.transform = CGAffineTransformIdentity;
         } completion:^(BOOL fin){}];
        
        [self fitText];
    }
    
    lblPlaceholder.hidden = textView.text.length > 0;
}

#pragma mark - Keyboard Notifications

- (void)listenForKeyboardNotifications:(BOOL)listen
{
    if (listen)
    {
        [self listenForKeyboardNotifications:NO];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    }
}

- (void)updateKeyboardProperties:(NSNotification*)n
{
    NSNumber *d = [[n userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    if (d!=nil && [d isKindOfClass:[NSNumber class]])
        keyboardAnimationDuration = [d floatValue];
    d = [[n userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    if (d!=nil && [d isKindOfClass:[NSNumber class]])
        keyboardAnimationCurve = [d integerValue];
    NSValue *v = [[n userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    if ([v isKindOfClass:[NSValue class]])
    {
        CGRect r = [v CGRectValue];
        r = [self.window convertRect:r toView:self];
        self.keyboardHeight = r.size.height;
    }
    if ([_delegate respondsToSelector:@selector(chatUpdatedKeyboardProperties:)])
        [_delegate performSelector:@selector(chatUpdatedKeyboardProperties:) withObject:self];
}

- (void)keyboardWillShow:(NSNotification*)n
{
    //NSLog(@"keyboardWillShow %@",[n description]);
    autoResizeOnKeyboardVisibilityChanged = YES;
    [self updateKeyboardProperties:n];
    if ([_delegate respondsToSelector:@selector(chatKeyboardWillShow:)])
        [_delegate performSelector:@selector(chatKeyboardWillShow:) withObject:self];
}

- (void)keyboardWillHide:(NSNotification*)n
{
    //NSLog(@"keyboardWillHide %@",[n description]);
    [self updateKeyboardProperties:n];
    if ([_delegate respondsToSelector:@selector(chatKeyboardWillHide:)])
        [_delegate performSelector:@selector(chatKeyboardWillHide:) withObject:self];
}

- (void)keyboardDidHide:(NSNotification*)n
{
    //NSLog(@"keyboardDidHide %@",[n description]);
    if ([_delegate respondsToSelector:@selector(chatKeyboardDidHide:)])
        [_delegate performSelector:@selector(chatKeyboardDidHide:) withObject:self];
}

- (void)keyboardDidShow:(NSNotification*)n
{
    //NSLog(@"keyboardDidShow %@",[n description]);
    if ([textView isFirstResponder])
    {
        [self beganEditing];
    }
    if ([_delegate respondsToSelector:@selector(chatKeyboardDidShow:)])
        [_delegate performSelector:@selector(chatKeyboardDidShow:) withObject:self];
}

static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve)
{
    UIViewAnimationOptions opt = (UIViewAnimationOptions)curve;
    return opt << 16;
}

#pragma mark - UITextFieldDelegate Delegate

- (void) textViewDidBeginEditing:(UITextView*)textview
{
    [self beganEditing];
    
    if ([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [_delegate performSelector:@selector(textViewDidBeginEditing:) withObject:textview];
}

- (void) textViewDidEndEditing:(UITextView*)textview
{
    [self endedEditing];
   
    autoResizeOnKeyboardVisibilityChanged = NO;
    
    if ([_delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [_delegate performSelector:@selector(textViewDidEndEditing:) withObject:textview];
}

- (BOOL) textView:(UITextView*)textview shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
   if ([text isEqualToString:@"\n"])
   {
       [self performSelector:@selector(returnButtonPressed:) withObject:nil afterDelay:.1];
       return NO;
   }
   else if (text.length > 0)
   {
      [self adjustTextInputHeightForText:[NSString stringWithFormat:@"%@%@", textview.text, text] animated:YES];
   }
   return YES;
}

- (void) textViewDidChange:(UITextView*)textview
{
    lblPlaceholder.hidden = textview.text.length > 0;
   
    [self fitText];
   
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)])
        [_delegate performSelector:@selector(textViewDidChange:) withObject:textview];
}

#pragma mark THChatInput Delegate

- (void) sendButtonPressed:(id)sender
{
    [_delegate chat:self sendWasPressed:self.text];
}

- (void) showAttachInput:(id)sender
{
   if ([_delegate respondsToSelector:@selector(chatShowAttachInput:)])
      [_delegate performSelector:@selector(chatShowAttachInput:) withObject:self];
}

- (void) showEmojiInput:(id)sender
{
   if ([_delegate respondsToSelector:@selector(chatShowEmojiInput:)])
   {
      if ([textView isFirstResponder] == NO) [textView becomeFirstResponder];

      [_delegate performSelector:@selector(chatShowEmojiInput:) withObject:self];
   }
}

- (void)returnButtonPressed:(id)sender
{
    [self sendButtonPressed:sender];
}

@end
