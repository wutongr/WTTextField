//
//  WTTextField.h
//  WTTextField+Validate
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTextField : UIView<UITextFieldDelegate>

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL secureTextEntry;

-(instancetype)initWithFrame:(CGRect)frame RegxArray:(NSArray *)regxArray;

@end

@interface WTTextFieldMatch : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

-(instancetype)initWithKey:(NSString *)key Value:(NSString *)value;

@end