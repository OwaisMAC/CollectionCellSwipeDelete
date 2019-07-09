//
//  CollectionViewCell.h
//  CollectionCellSwipeDelete
//
//  Created by MAC on 6/12/19.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellDelegate <NSObject>
-(void) deleteTapped:(UICollectionViewCell*) cell;
@end

@interface CollectionViewCell : UICollectionViewCell
    @property (nonatomic, weak) id<CellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
