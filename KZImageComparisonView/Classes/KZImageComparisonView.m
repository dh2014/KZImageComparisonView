//
//  PhotoSliderView.m
//  PhotoSliderView
//
//  Created by Zhamtsuev Konstantin on 29/07/16.
//  Copyright © 2016 KonstantinZhamtsuev. All rights reserved.
//

#import "KZImageComparisonView.h"

@interface KZImageComparisonView ()

@property (nonatomic, strong) UIView *leftImageBoundingView;
@property (nonatomic, strong) UIView *rightImageBoundingView;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIImageView *separatingImageView;


@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGFloat slidingStartPosition;

@end

@implementation KZImageComparisonView

- (instancetype)initWithLeftImage:(UIImage *)leftImage
                       rightImage:(UIImage *)rightImage
                   separatingImage:(UIImage *)separatingImage {

    CGRect frame = CGRectMake(0.0f,
                              0.0f,
                              MAX(leftImage.size.width, rightImage.size.width),
                              MAX(leftImage.size.height, rightImage.size.height));
    self = [super initWithFrame:frame];
    
    if (self) {

        [self setup];
        self.separatingImage = separatingImage;
        self.rightImage = rightImage;
        self.leftImage = leftImage;
        
    }
    
    return self;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        [self setup];
        
    }
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
        
    }
    
    return self;
    
}

- (void)setup {
    
    _separatorRelativePosition = 0.5;
    
    _leftImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _leftImageView.contentMode = self.contentMode;
    _leftImageView.clipsToBounds = YES;
    
    _leftImageBoundingView = [[UIView alloc] init];
    _leftImageBoundingView.clipsToBounds = YES;
    
    _rightImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _rightImageView.contentMode = self.contentMode;
    _rightImageView.clipsToBounds = YES;
    
    _rightImageBoundingView = [[UIView alloc] init];
    _rightImageBoundingView.clipsToBounds = YES;

    
    _separatingImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _separatingImageView.userInteractionEnabled = YES;
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideRecognized:)];
    _panGestureRecognizer.cancelsTouchesInView = NO;
    [_separatingImageView addGestureRecognizer:self.panGestureRecognizer];
    
    
    [self addSubview:_leftImageBoundingView];
    [self addSubview:_rightImageBoundingView];

    [self.leftImageBoundingView addSubview:_leftImageView];
    [self.rightImageBoundingView addSubview:_rightImageView];

    [self addSubview:_separatingImageView];
    
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGPoint separatingViewPosition = CGPointMake(self.separatorRelativePosition * self.bounds.size.width, self.bounds.size.height / 2.0f);
    
    self.leftImageBoundingView.frame = CGRectMake(0.0f,
                                                  0.0f,
                                                  separatingViewPosition.x,
                                                  self.bounds.size.height);
    self.rightImageBoundingView.frame = CGRectMake(separatingViewPosition.x,
                                                  0.0f,
                                                  self.bounds.size.width - separatingViewPosition.x,
                                                  self.bounds.size.height);

    self.separatingImageView.center = separatingViewPosition;
    
    self.leftImageView.frame = self.bounds;
    self.rightImageView.frame = CGRectMake(-separatingViewPosition.x,
                                           self.bounds.origin.y,
                                           self.bounds.size.width,
                                           self.bounds.size.height);
    
}

#pragma mark - touches events

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint touchPointInSeparatingImageView = [self.separatingImageView convertPoint:point fromView:self];

    UIView *result = [self.separatingImageView hitTest:touchPointInSeparatingImageView withEvent:event];
    if (result && !self.clipsToBounds) {
        
        return result;
        
    }
    
    return [super hitTest:point withEvent:event];
}

- (IBAction)slideRecognized:(UIPanGestureRecognizer *)sender {
    
    CGPoint locationInView = [sender locationInView:self];
    
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            self.slidingStartPosition = locationInView.x;
            break;
            
        }
            
        case UIGestureRecognizerStateChanged: {
            
            CGFloat delta = locationInView.x - self.slidingStartPosition;
            self.slidingStartPosition = locationInView.x;
            self.separatorRelativePosition += delta / self.bounds.size.width;
            [self setNeedsLayout];
            break;
            
        }
            
        default:
            break;
            
    }

}

#pragma mark - accessors

- (void)setSeparatorRelativePosition:(CGFloat)separatorRelativePosition {
    
    if (_separatorRelativePosition != separatorRelativePosition) {
        
        _separatorRelativePosition = MIN(1.0f, MAX(0.0f, separatorRelativePosition));
        [self setNeedsLayout];
        
    }
    
}

- (void) setContentMode:(UIViewContentMode)contentMode {
    
    [super setContentMode:contentMode];
    self.leftImageView.contentMode = contentMode;
    self.rightImageView.contentMode = contentMode;
    
}

- (void)setSeparatingImage:(UIImage *)separatingImage {
    
    if (self.separatingImageView.image != separatingImage) {
        
        self.separatingImageView.image = separatingImage;
        self.separatingImageView.bounds = CGRectMake(0, 0, separatingImage.size.width, separatingImage.size.height);
    }

}

- (void)setLeftImage:(UIImage *)leftimage {
    
    if (self.leftImageView.image != leftimage) {
        
        self.leftImageView.image = leftimage;
        
    }
}

- (void)setRightImage:(UIImage *)rightImage {
    
    if (_rightImageView.image != rightImage) {
        
        _rightImageView.image = rightImage;
        
    }
    
}


- (UIImage *)leftImage {
    
    return _leftImageView.image;
    
}

- (UIImage *)rightImage {
    
    return _rightImageView.image;
    
}

- (UIImage *)separatingImage {
    
    return _separatingImageView.image;
    
}

@end
