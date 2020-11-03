//
//  BigPhotoCell.h
//  Doctor
//
//  Created by 赵洋 on 15/7/9.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BigPhotoCell;
@protocol BigPhotoCellDelegate <NSObject>

@optional
-(void)clickedBigPhotoCell:(BigPhotoCell *)cell;

-(void)bigPhotoCell:(BigPhotoCell*)cell willZoomImage:(UIImageView *)image;
-(void)bigPhotoCell:(BigPhotoCell *)cell didZoomImage:(UIImageView *)image;

@end
@interface BigPhotoCell : UICollectionViewCell
@property (nonatomic ,strong) id photo;
@property(nonatomic,assign) BOOL zoomPhotosToFill;

@property(nonatomic,weak) id<BigPhotoCellDelegate> delegate;
@end
