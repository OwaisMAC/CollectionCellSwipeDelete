//
//  ViewController.m
//  CollectionCellSwipeDelete
//
//  Created by MAC on 6/12/19.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, CellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController
NSMutableArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     data = [NSMutableArray arrayWithObjects:@"Tile 1 object",
             @"Tile 2 object", @"Tile 3 object",
             @"Tile 4 object", @"Tile 5 object",
             @"Tile 6 object", @"Tile 7 object",
             @"Tile 8 object", @"Tile 9 object",
             @"Tile 10 object", @"Tile 11 object",
             @"Tile 12 object", @"Tile 13 object",
             @"Tile 14 object", @"Tile 15 object",
             @"Tile 16 object", @"Tile 17 object",
             @"Tile 18 object", @"Tile 19 object", @"Tile 20 object",nil];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    UILabel *label = [cell viewWithTag:10];
    label.text = data[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return data.count;
}


- (void)deleteTapped:(UICollectionViewCell *)cell{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [data removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}

@end
