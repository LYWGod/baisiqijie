//
//  LYWCacheCell.m
//  百思奇解
//
//  Created by LYW on 2016/11/5.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWCacheCell.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"
@implementation LYWCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIActivityIndicatorView *Indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [Indicator startAnimating];
        self.accessoryView = Indicator;
        self.textLabel.text = [NSString stringWithFormat:@"清除缓存(正在计算缓存大小...)"];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            unsigned long long size = @"/Users/kevindemac/Library/Developer/CoreSimulator/Devices/EEB5D3E1-C6B1-4429-B8E4-C09DAA953236/data/Containers/Data/Application/F76C3D8A-0065-4592-BFF4-E3852113C5D1/Library/Caches/Custom".fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            NSString *sizeText = nil;
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
        
            NSString *textLab = [NSString stringWithFormat:@"清除缓存(%@)",sizeText];
            
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.accessoryView = nil;
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.textLabel.text = textLab;
                [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];

            });
        });
    }
    
    return self;
}


- (void)clearCache
{
    // 弹出指示器
    [SVProgressHUD showInfoWithStatus:@"正在清除缓存..."];
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //文件管理者
            NSFileManager *mgr = [NSFileManager defaultManager];
            //移除该文件夹
            [mgr removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"] error:nil];
            //再创建该文件夹
       [mgr createDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"] withIntermediateDirectories:YES attributes:nil error:nil];
            LYWLog(@"123456789%@",NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES).lastObject);
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                // 设置文字
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}


/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}



@end
