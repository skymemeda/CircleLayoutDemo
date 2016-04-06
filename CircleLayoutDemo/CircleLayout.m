//
//  CircleLayout.m
//  CircleLayoutDemo
//
//  Created by sks on 16/4/5.
//  Copyright © 2016年 sks. All rights reserved.
//

#import "CircleLayout.h"

@implementation CircleLayout
{
    NSMutableArray *       _attributeArray;
    int                    _itemCount;
    CGPoint                _center;
    CGFloat                _radius;
    NSMutableArray        *_deleteIndexPaths;
    NSMutableArray        *_insertIndexPaths;
                     
}

- (void)prepareLayout
{
    [super prepareLayout];
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    _attributeArray = [[NSMutableArray alloc]init];
    //半径、圆心
    _radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height)/2.5;
    _center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2);
}

- (CGSize)collectionViewContentSize
{
    return  self.collectionView.frame.size;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.size = CGSizeMake(60, 60);
    CGFloat x = _center.x + cos(2*M_PI*indexPath.item/_itemCount)*_radius;
    CGFloat y = _center.y + sin(2*M_PI*indexPath.item/_itemCount)*_radius;
    attribute.center = CGPointMake(x, y);
    return attribute;
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    for(int index = 0;index<_itemCount;index++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributeArray addObject:attribute];
    }
    return _attributeArray;
}

- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    _deleteIndexPaths = [NSMutableArray array];
    _insertIndexPaths = [NSMutableArray array];
    for(UICollectionViewUpdateItem *item in updateItems)
    {
        if(item.updateAction == UICollectionUpdateActionInsert)
        {
            [_insertIndexPaths addObject:item.indexPathAfterUpdate];
        }
        else if(item.updateAction == UICollectionUpdateActionDelete)
        {
            [_deleteIndexPaths addObject:item.indexPathBeforeUpdate];
        }
    }
}
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attribute = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    if([_insertIndexPaths containsObject:itemIndexPath])
    {
        if(!attribute)
        {
            attribute = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        attribute.center = _center;
        attribute.alpha = 0.0;
    }
    return attribute;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attribute = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    if([_deleteIndexPaths containsObject:itemIndexPath])
    {
        if(!attribute)
        {
            attribute = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        }
        attribute.center = _center;
        attribute.alpha = 0.0;
    }
    return attribute;
}
@end
