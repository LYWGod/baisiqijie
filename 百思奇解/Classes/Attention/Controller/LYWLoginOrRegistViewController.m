//
//  LYWLoginOrRegistViewController.m
//  百思奇解
//
//  Created by LYW on 2016/10/20.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWLoginOrRegistViewController.h"

@interface LYWLoginOrRegistViewController ()

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobilePhoneText;
@property (weak, nonatomic) IBOutlet UITextField *PassWordText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LeadingToSuper;
@property (weak, nonatomic) IBOutlet UITextField *RegistMobilePhoneText;
@property (weak, nonatomic) IBOutlet UITextField *RegistPassWordText;

@end

@implementation LYWLoginOrRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 *  快速注册按钮点击事件
 */
- (IBAction)loginBtnClick
{
    if (self.LeadingToSuper.constant) {
        self.LeadingToSuper.constant = 0;
        [self.registBtn setTitle:@"注册帐号" forState:UIControlStateNormal];

    }
    else
    {
        self.LeadingToSuper.constant = - self.view.LYW_W;
        [self.registBtn setTitle:@"已有帐号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (IBAction)CloseBtnClick
{
    LYWLogFunc
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





/**
 *  登录按钮点击事件
 */
- (IBAction)loginBtnClicke {
}

/**
 *  忘记密码点击事件
 */
- (IBAction)forgetBtnClick {
}







@end
