//
//  LYWSeeBIgPictureController.m
//  百思奇解
//
//  Created by Leo的Mac on 16/11/11.
//  Copyright © 2016年 LYW. All rights reserved.
//

#import "LYWSeeBIgPictureController.h"
#import "LYWTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
@interface LYWSeeBIgPictureController ()<UIScrollViewDelegate>

/** 图片控件 */
@property (weak, nonatomic)UIImageView *imageView;

@end

@implementation LYWSeeBIgPictureController

static NSString *const LYWAssetCollectionName = @"小蓝百思";

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame  = [UIScreen mainScreen].bounds;
    //插入到第一个
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_topicModel.image0]];
    [scrollView addSubview:imageView];
    
    imageView.LYW_W = scrollView.LYW_W;
    imageView.LYW_H = self.topicModel.height * imageView.LYW_W / self.topicModel.width;
    imageView.LYW_X = 0;
    //如果图片尺寸超出全屏
    if (imageView.LYW_H >= scrollView.LYW_H) {
        imageView.LYW_Y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.LYW_H);
    }else
    {   //图片大小不超出全屏，让它居中显示
        imageView.LYW_centerY = scrollView.LYW_H * 0.5;
    }
    
    self.imageView = imageView;
    
    // 缩放比例
    CGFloat scale =  self.topicModel.width / imageView.LYW_W;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
    
}


#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//返回
- (IBAction)back:(id)sender
{
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存图片到相册
- (IBAction)saveBtnClick:(id)sender
{
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [SVProgressHUD showErrorWithStatus:@"因为系统原因, 无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        LYWLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success == NO) {
            [self showError:@"保存图片失败!"];
            return;
        }
        
        // 2.获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败!"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success == NO) {
                [self showError:@"保存图片失败!"];;
            } else {
                [self showSuccess:@"保存图片成功!"];;
            }
        }];
    }];
}

/**
 *  获得相簿
 */
- (PHAssetCollection *)createdAssetCollection
{
    // 从已存在相簿中查找这个应用对应的相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:LYWAssetCollectionName]) {
            return assetCollection;
        }
    }
    
    // 没有找到对应的相簿, 得创建新的相簿
    
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:LYWAssetCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}


    
//    // 取得授权状态
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    
//    // 判断当前状态
//    if (status == PHAuthorizationStatusAuthorized) {
//        // 当前App访问【Photo】运用
//        [self saveImage];
//    }else if (status == PHAuthorizationStatusDenied){
//        // 拒绝当前App访问【Photo】运用
//        [SVProgressHUD showInfoWithStatus:@"提醒用固话打开访问开关【设置】-【隐私】—【照片】-【百思不得姐】"];
//    }else if (status == PHAuthorizationStatusNotDetermined){
//        // 从未弹框让用户做出选择（用户还没有做出选择）用户未决定
//        
//        // 弹框让用户做出选择
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            if (status == PHAuthorizationStatusAuthorized) {
//                [self saveImage];
//            }else if (status == PHAuthorizationStatusDenied){
//                // 用户拒绝当前App访问【Photo】运用
//                // 用户刚做出拒绝当前App的举动
//            }
//        }];
//    }else if (status == PHAuthorizationStatusRestricted){
//        // 级别的限制（用户都无法给你授权）
//        [SVProgressHUD showErrorWithStatus:@"由于系统原因，我IFA保存图片"];
//    }
//}
//
///**
// * 保存图片到自定义Album
// */
//- (void)saveImage{
//    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
//    NSError *error = nil;
//    // 用来抓取PHAsset的字符串标识
//    __block NSString *assetId = nil;
//    // 用来抓取PHAssetCollectin的字符串标识符
//    __block NSString *assetCollectionId = nil;
//    
//    // 保存照片到【Camera Roll】(相机胶卷)
//    [library performChangesAndWait:^{
//        assetId = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
//    } error:&error];
//    
//    // 获取曾经创建过的自定义相册
//    PHAssetCollection *createdAssetCollection = nil;
//    PHFetchResult <PHAssetCollection *>*assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        if ([assetCollection.localizedTitle isEqualToString:LYWAssetCollectionName]) {
//            createdAssetCollection = assetCollection;
//            break;
//        }
//    }
//    
//    // 如果这个自定义相册没有被创建过
//    if (createdAssetCollection == nil) {
//        // 创建 新的【自定义的Album】(相簿\相册)
//        [library performChangesAndWait:^{
//            assetCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:LYWAssetCollectionName].placeholderForCreatedAssetCollection.localIdentifier;
//        } error:&error];
//        
//        // 抓取刚刚创建完的相册对象
//        createdAssetCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionId] options:nil].firstObject;
//    }
//    
//    // 将【Camera Roll】(相机胶卷)的图片 添加到 【自定义Album】(相簿\相册)中
//    [library performChangesAndWait:^{
//        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
//        
//        // 图片
//        [request addAssets:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil]];
//    } error:&error];
//    
//    // 提示信息
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存图片失败!"];
//    } else {
//        [SVProgressHUD showSuccessWithStatus:@"保存图片成功!"];
//    }
//}
//
//
//
//- (void)getCameraRollAlbum
//{
//    // 获得Camera Roll【相机胶卷】
//    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
//    
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        LYWLog(@"%@", assetCollection.localizedTitle);
//    }
//}
//
//- (void)getAllDIYAlbums
//{
//    // 获得所有的自定义相册
//    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        LYWLog(@"%@", assetCollection.localizedTitle);
//    }
//}
//
//- (void)asyncOperation
//{
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 异步执行修改操作
//        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) { // 修改完毕后，会自动调用completionHandler这个block
//        LYWLog(@"1");
//    }];
//    
//    LYWLog(@"2");
//}


@end
