//
//  CollectionViewCell.m
//  CollectionCellSwipeDelete
//
//  Created by MAC on 6/12/19.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "CollectionViewCell.h"
@implementation CollectionViewCell
CGPoint originalLocation;

CGRect targetContentViewFrame;
CGRect targetContentViewAnimationFrame;
CGRect initialContentViewFrame;
CGRect initialContentViewAnimationFrame;

- (void)awakeFromNib{
    [super awakeFromNib];
    
    CGFloat cellWidth = self.frame.size.width;
    CGFloat cellHeight = self.frame.size.height;
    CGFloat swipeMargin = -60.0;
    CGFloat swipeAnimationMargin = -70.0;
    CGFloat initialMargin = 0.0;
    CGFloat initialAnimationMargin = 10.0;
    CGFloat yPoint = 0.0;
    
    UIView *actionView = [[UIView alloc] init];
    [self insertSubview:actionView belowSubview:self.contentView];
    actionView.translatesAutoresizingMaskIntoConstraints = false;
    actionView.backgroundColor = [UIColor redColor];
    actionView.frame = CGRectMake(swipeMargin*-2, 0.0, cellWidth - (swipeMargin*-2), cellHeight);
    
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(actionView.frame.size.width - (swipeMargin*-1), 0.0, swipeMargin*-1, cellHeight)];
    deleteButton.backgroundColor = [UIColor clearColor];
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [deleteButton addTarget:self action:@selector(deleteTapped) forControlEvents:UIControlEventTouchUpInside];
    [actionView addSubview:deleteButton];
    
    targetContentViewFrame = CGRectMake(swipeMargin, yPoint, cellWidth, cellHeight);
    targetContentViewAnimationFrame = CGRectMake(swipeAnimationMargin, yPoint, cellWidth, cellHeight);
    initialContentViewFrame = CGRectMake(initialMargin, yPoint, cellWidth, cellHeight);
    initialContentViewAnimationFrame = CGRectMake(initialAnimationMargin, yPoint, cellWidth, cellHeight);
    
    //[self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(containerViewPanGestureRecognized:)]];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openWithAnimation)];
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(closeWithAnimation)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeLeftGesture];
    [self addGestureRecognizer:swipeRightGesture];
    
}

-(void) deleteTapped{
    NSLog(@"Delete tapped");
    [_delegate deleteTapped:self];
}


- (void)containerViewPanGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            originalLocation = [gestureRecognizer locationInView:self.contentView];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // ... do animation or operation here
            CGFloat newX = [gestureRecognizer locationInView:self].x;
            
            if ((newX < originalLocation.x) || (self.contentView.frame.origin.x < 0)){
                if ((self.contentView.frame.origin.x < 0) && (newX > originalLocation.x)){
                    [self closeWithAnimation];
                }else{
                    [self openWithAnimation];
                }
            }
        }
            break;
        default:
            break;
    }

}

- (void) closeWithAnimation{
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.frame = initialContentViewAnimationFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.contentView.frame = initialContentViewFrame;
        } completion:NULL];
    }];
}

- (void) openWithAnimation{
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.frame = targetContentViewAnimationFrame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.contentView.frame = targetContentViewFrame;
        } completion:NULL];
    }];
}

@end
