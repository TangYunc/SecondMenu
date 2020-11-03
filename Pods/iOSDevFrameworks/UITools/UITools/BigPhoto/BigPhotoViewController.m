//
//  BigPhotoViewController.m
//  Doctor
//
//  Created by 赵洋 on 15/7/9.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "BigPhotoViewController.h"
#import "UINavigationController+NavAlpha.h"
#import "BigPhotoCell.h"
#import "UIImage+Tint.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "ToolsHeader.h"
#import "YXActionSheet.h"

@interface BigPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BigPhotoCellDelegate>
@property(nonatomic,weak) UICollectionView *collectionView;

@property(nonatomic,weak) UILabel  *titleLabel;
@end

@implementation BigPhotoViewController

static NSString * const reuseIdentifier = @"bigPhotoCell";

-(NSArray *)photosArray{
    if (_photosArray==nil) {
        _photosArray=@[];
    }
    return _photosArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navBarTintColor = RGB_COLOR_WITH_0x(BlackTextColor);
    self.backItemType = NavigationBackItemTypeWhite;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB_COLOR_WITH_0x(WhiteColor)}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.translucent=YES;
    
    [self.navigationController setEdgesForExtendedLayout:UIRectEdgeAll];
  
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navBarTintColor = RGB_COLOR_WITH_0x(NavBgColor);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB_COLOR_WITH_0x(BlackTextColor)}];
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)setEdit:(BOOL)edit{
    _edit=edit;
    if (edit) {
        [self setNavigationRigthItemTitle:nil itemImage:[[UIImage imageNamed:@"delete_image_icon"]yx_imageWithTintColor:RGB_COLOR_WITH_0x(WhiteColor)] action:@selector(deleteImage)];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"123";
    self.backItemType = NavigationBackItemTypeWhite;

    self.title=[NSString stringWithFormat:@"%d/%zd",(int)(self.currentIndex+1),self.photosArray.count];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.itemSize=self.view.size;
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    layout.sectionInset=UIEdgeInsetsZero;
    
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height) collectionViewLayout:layout];
   
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.pagingEnabled=YES;
    [self.view addSubview:collectionView];
    self.collectionView=collectionView;

    //滚动到某一个位置
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionView registerClass:[BigPhotoCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark -点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 删除图片*/
-(void)deleteImage{
    __weak typeof(self) weakSelf = self;
    //删除照片
    [YXActionSheet shareActionSheetWithTitle:@"要删除这张照片吗?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"删除"] clickedButtonBlock:^(NSInteger buttonIndex) {
        [weakSelf actionSheetClickedButtonAtIndex:buttonIndex];
    }];
}
- (void)actionSheetClickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) { //删除
        NSString *currentIndex =[self.title componentsSeparatedByString:@"/"].firstObject;
        NSUInteger index=[currentIndex integerValue]-1;
        
        
        //删除数据源
        NSMutableArray *photos=self.photosArray.mutableCopy;
        id object=photos[index];
        
        [photos removeObjectAtIndex:index];
        self.photosArray=photos.copy;
        
        
        //代理执行方法
        if ([self.delegate respondsToSelector:@selector(deleteImageWithImage:andPosition:andPhotoType:)]) {
            [self.delegate deleteImageWithImage:object andPosition:index andPhotoType:self.photoType];
        }
        
        if (self.photosArray.count==0) {//没有照片就直接退出当前的控制器
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0];
        NSIndexPath *indexPath1=[NSIndexPath indexPathForItem:index-1 inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        

        if (index==self.photosArray.count) {//判断是不是最后
            [self.collectionView scrollToItemAtIndexPath:indexPath1 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            self.title=[NSString stringWithFormat:@"%zd/%zd",index,self.photosArray.count];
        }else{
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            self.title=[NSString stringWithFormat:@"%zd/%zd",index+1,self.photosArray.count];
        }

    }
}


-(void)clickedBigPhotoCell:(BigPhotoCell *)cell{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BigPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    id object=self.photosArray[indexPath.row];
    cell.photo = object;
    cell.delegate=self;
    cell.zoomPhotosToFill = self.zoomPhotosToFill;
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index= (int)((scrollView.contentOffset.x/kScreenWidth)+0.5);
    self.title=[NSString stringWithFormat:@"%d/%zd",index+1,self.photosArray.count];

    self.currentIndex=index;
}

#pragma mark - BigPhotoCellDelegate
-(void)bigPhotoCell:(BigPhotoCell*)cell willZoomImage:(UIImageView *)image{
    self.collectionView.scrollEnabled=NO;
}
-(void)bigPhotoCell:(BigPhotoCell *)cell didZoomImage:(UIImageView *)image{
    self.collectionView.scrollEnabled=YES;
}
@end
