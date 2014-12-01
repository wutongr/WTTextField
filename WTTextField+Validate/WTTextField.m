//
//  WTTextField.m
//  WTTextField+Validate
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "WTTextField.h"

#define kTextFieldHeight 44.0f
#define kLabelHeight 23.0f

#define GCOLOR [UIColor lightGrayColor]
#define BCOLOR [UIColor blackColor]

@interface WTTextField (){
    NSArray *_regxArray;
    NSPredicate *_predicate;
    UITextField *_textField;
    UIView *_bgView;
    float height;
}

@end

@implementation WTTextField

-(instancetype)initWithFrame:(CGRect)frame RegxArray:(NSArray *)regxArray{
    if(self = [super initWithFrame:frame]){
        _regxArray = regxArray;
        height = kTextFieldHeight + kLabelHeight * _regxArray.count;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        self.layer.cornerRadius = 5;
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(5, 0, frame.size.width - 10, kTextFieldHeight)];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.borderStyle = UITextBorderStyleNone;
  
        _textField.delegate = self;
        [self addSubview:_textField];
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(5, kTextFieldHeight, frame.size.width - 10, height - kTextFieldHeight)];
        [self addSubview:_bgView];
        
        //在bgView中设置
        for(int i = 0; i < _regxArray.count; i++){
            WTTextFieldMatch *match = _regxArray[i];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, kLabelHeight * i, _bgView.frame.size.width - 2, kLabelHeight)];
            lab.text = match.key;
            lab.font = [UIFont systemFontOfSize:13];
            lab.tag = 1000 + i;
            lab.textColor = GCOLOR;
            [_bgView addSubview:lab];
        }
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textField.placeholder = _placeholder;
    [_textField setValue:GCOLOR forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _textField.textColor = _textColor;
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    _textField.secureTextEntry = _secureTextEntry;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *realText;
    NSString *text = textField.text;
    if(![string isEqualToString:@""]){
        realText = [NSString stringWithFormat:@"%@%@",text,string];
    }else{
        realText = [text substringWithRange:NSMakeRange(0, text.length - 1)];
    }
    
    for(int i = 0; i<_regxArray.count; i++){
        WTTextFieldMatch *match = _regxArray[i];
        UILabel *lab = (UILabel *)[_bgView viewWithTag:1000 + i];
        NSString *regx =match.value;
        _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
        if([realText isEqualToString:@""]){
            lab.textColor = GCOLOR;
        }else{
            if(![_predicate evaluateWithObject:realText]){
                lab.textColor = BCOLOR;
            }else{
                lab.textColor = GCOLOR;
            }
        }
        
    }
    return YES;
}

@end

@implementation WTTextFieldMatch

-(instancetype)initWithKey:(NSString *)key Value:(NSString *)value{
    if(self = [super init]){
        _key = key;
        _value = value;
    }
    return self;
}

@end