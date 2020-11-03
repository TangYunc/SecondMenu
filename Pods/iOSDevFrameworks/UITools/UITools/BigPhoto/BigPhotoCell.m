//
//  BigPhotoCell.m
//  Doctor
//
//  Created by 赵洋 on 15/7/9.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "BigPhotoCell.h"
#import "BigImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
@interface BigPhotoCell ()<UIScrollViewDelegate,BigImageViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) BigImageView *photoImageView;
@end

@implementation BigPhotoCell

-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        
        // Setup
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoImageView = [[BigImageView alloc] initWithFrame:frame];
        self.photoImageView.tapDelegate = self;
        self.photoImageView.contentMode = UIViewContentModeCenter;
        self.photoImageView.backgroundColor = [UIColor blackColor];
        [self.scrollView addSubview:self.photoImageView];
        
            
    }
    return self;
}


-(void)showNav{
    if ([self.delegate respondsToSelector:@selector(clickedBigPhotoCell:)]) {
        [self.delegate clickedBigPhotoCell:self];
    }
}

- (void)prepareForReuse {
    self.photo = nil;
    self.photoImageView.hidden = NO;
    self.photoImageView.image = nil;
}

- (void)setImageHidden:(BOOL)hidden {
    self.photoImageView.hidden = hidden;
}

#pragma mark - Image

- (void)setPhoto:(id)photo {
    _photo = photo;
    
    if (photo) {
        if ([photo isKindOfClass:[NSString class]]) {
            __weak typeof(self) weakSelf = self;
            [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                weakSelf.photoImageView.image = image;
                [weakSelf displayImage];
            }];
        }else if([photo isKindOfClass:[UIImage class]]){
            self.photoImageView.image = photo;
            [self displayImage];
        }
    } else {
        [self showLoadingIndicator];
    }
}

// Get and display image
- (void)displayImage {
    if (_photo) {
        
        // Reset
        self.scrollView.maximumZoomScale = 1;
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.zoomScale = 1;
        self.scrollView.contentSize = CGSizeMake(0, 0);
        
        if (self.photoImageView.image) {
        
            CGRect photoImageViewFrame;
            photoImageViewFrame.origin = CGPointZero;
            photoImageViewFrame.size = self.photoImageView.image.size;
            self.photoImageView.frame = photoImageViewFrame;
            self.scrollView.contentSize = photoImageViewFrame.size;

            // Set zoom to minimum zoom
            [self setMaxMinZoomScalesForCurrentBounds];
        }
        [self setNeedsLayout];
    }
}

- (void)showLoadingIndicator {
    self.scrollView.zoomScale = 0;
    self.scrollView.minimumZoomScale = 0;
    self.scrollView.maximumZoomScale = 0;
}

#pragma mark - Setup
- (CGFloat)initialZoomScaleWithMinScale {
    CGFloat zoomScale = self.scrollView.minimumZoomScale;
    if (self.photoImageView && self.zoomPhotosToFill) {
        CGSize boundsSize = self.bounds.size;
        CGSize imageSize = self.photoImageView.image.size;
        CGFloat boundsAR = boundsSize.width / boundsSize.height;
        CGFloat imageAR = imageSize.width / imageSize.height;
        CGFloat xScale = boundsSize.width / imageSize.width;
        CGFloat yScale = boundsSize.height / imageSize.height;
        if (ABS(boundsAR - imageAR) < 0.17) {
            zoomScale = MAX(xScale, yScale);
            zoomScale = MIN(MAX(self.scrollView.minimumZoomScale, zoomScale), self.scrollView.maximumZoomScale);
        }
    }
    return zoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds {
    
    self.scrollView.maximumZoomScale = 1;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.zoomScale = 1;
    
    if (self.photoImageView.image == nil) return;
    
//    self.photoImageView.frame = CGRectMake(0, 0, self.photoImageView.frame.size.width, self.photoImageView.frame.size.height);
    
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = self.photoImageView.image.size;
    
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    CGFloat maxScale = 2;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        maxScale = 4;
    }
    
    if (xScale >= 1 && yScale >= 1) {
        minScale = 1.0;
    }
    
    self.scrollView.maximumZoomScale = maxScale;
    self.scrollView.minimumZoomScale = minScale;
    
    self.scrollView.zoomScale = [self initialZoomScaleWithMinScale];
    
    if (self.scrollView.zoomScale != minScale) {
        self.scrollView.contentOffset = CGPointMake((imageSize.width * self.scrollView.zoomScale - boundsSize.width) / 2.0,
                                         (imageSize.height * self.scrollView.zoomScale - boundsSize.height) / 2.0);
    }
    
    self.scrollView.scrollEnabled = NO;
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.photoImageView.frame;
    
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    if (!CGRectEqualToRect(self.photoImageView.frame, frameToCenter))
        self.photoImageView.frame = frameToCenter;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.photoImageView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.delegate respondsToSelector:@selector(bigPhotoCell:willZoomImage:)]) {
        [self.delegate bigPhotoCell:self willZoomImage:self.photoImageView];
    }
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    if ([self.delegate respondsToSelector:@selector(bigPhotoCell:didZoomImage:)]) {
        [self.delegate bigPhotoCell:self didZoomImage:self.photoImageView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Tap Detection

- (void)handleSingleTap:(CGPoint)touchPoint {
    [self showNav];
}

- (void)handleDoubleTap:(CGPoint)touchPoint {
    if (self.scrollView.zoomScale != self.scrollView.minimumZoomScale && self.scrollView.zoomScale != [self initialZoomScaleWithMinScale]) {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        // Zoom in to twice the size
        CGFloat newZoomScale = ((self.scrollView.maximumZoomScale + self.scrollView.minimumZoomScale) / 2);
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

// Image View
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self handleSingleTap:[touch locationInView:imageView]];
}
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:imageView]];
}
@end
