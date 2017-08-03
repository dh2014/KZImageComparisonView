//
//  KZImageComparisonView.h
//  KZImageComparisonView
//
//  Created by Zhamtsuev Konstantin on 2/08/17.
//  Copyright © 2016 KonstantinZhamtsuev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  A KZImageComparisonView allows u to present two images along with a visual control used to slide the separating view.
 */
IB_DESIGNABLE @interface KZImageComparisonView : UIView

/**
 *  Returns an image comparison view initialized with the specified images.
 *  The images you specified are used to configure the initial size of the comparison view itself. Use constraints and the comparison view's content mode to adjust the comparison view's final size onscreen.
 */
- (instancetype)initWithLeftImage:(UIImage *)leftImage
                       rightImage:(UIImage *)rightImage
                  separatingImage:(UIImage *)separatingImage;

@property (nonatomic, strong) IBInspectable UIImage *leftImage;
@property (nonatomic, strong) IBInspectable UIImage *rightImage;
@property (nonatomic, strong) IBInspectable UIImage *separatingImage;

/**
 *  The slider’s current value.
 *  Use this property to get and set the slider’s current value.
 *  If you try to set a value that is below the minimum or above the maximum, the minimum or maximum value is set instead. The default value of this property is 0.5.
 */
@property (nonatomic) CGFloat separatorRelativePosition;

@end

NS_ASSUME_NONNULL_END
