//
//  BigPhotoViewController.h
//  Doctor
//
//  Created by 赵洋 on 15/7/9.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRootViewController.h"
typedef enum {
    BigPhotoTypeSheet=0,
    BigPhotoTypeMedcine,
    BigPhotoTypeRadial
}BigPhotoType;

@protocol BigPhotoViewControllerDelegate <NSObject>

@optional
-(void)deleteImageWithImage:(id)image andPosition:(NSUInteger)index andPhotoType:(BigPhotoType)type;

@end

@interface BigPhotoViewController : BaseRootViewController

@property(nonatomic,strong)NSArray *photosArray;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,assign) BOOL edit;
@property(nonatomic,assign) BOOL zoomPhotosToFill;

/**查看图片的类型*/
@property(nonatomic,assign) BigPhotoType photoType;

@property(nonatomic,weak) id<BigPhotoViewControllerDelegate> delegate;


@end
