//
//  ViewController.m
//  WTTextField+Validate
//
//  Created by Yorke on 14/11/30.
//  Copyright (c) 2014年 Yorke. All rights reserved.
//

#import "ViewController.h"
#import "WTTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ar = [NSArray arrayWithObjects:
                   [[WTTextFieldMatch alloc]initWithKey:@"包含8-36位字符" Value:@"^\\S{8,36}$"],
                   [[WTTextFieldMatch alloc]initWithKey:@"至少一个大小写混合字母" Value:@"^.*[a-z].*[A-Z].*$"],
                   [[WTTextFieldMatch alloc]initWithKey:@"至少包含一个数字" Value:@"^.*[1-9].*$"],
                   [[WTTextFieldMatch alloc]initWithKey:@"不能包含昵称" Value:@"^((?!wutongr).)*$"],
                   [[WTTextFieldMatch alloc]initWithKey:@"不能包含空格" Value:@"^\\S+$"],nil];
    
    WTTextField *te = [[WTTextField alloc]initWithFrame:CGRectMake(50, 100, 200, 100) RegxArray:ar];
    te.placeholder = @"密码";
    te.textColor = [UIColor lightGrayColor];
    te.secureTextEntry = YES;
    [self.view addSubview:te];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
