//
//  SPViewController.m
//  SphericalCollectionView
//
//  Created by Shunji Li on 9/8/13.
//  Copyright (c) 2013 Shunji Li. All rights reserved.
//

#import "SPViewController.h"
#import "SPSphericalCollectionView.h"
#import "SPSphericalCollectionViewCell.h"
#import "SPCollectionViewSphericalLayout.h"

@interface SPViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setFrame: [[UIScreen mainScreen] bounds]];
    SPCollectionViewSphericalLayout *layout = [[SPCollectionViewSphericalLayout alloc] init];
    SPSphericalCollectionView *sphericalView = [[SPSphericalCollectionView alloc] initWithFrame:[[self view] bounds] collectionViewLayout: layout];
    [sphericalView setBackgroundColor:[UIColor blueColor]];
    [sphericalView registerClass:[SPSphericalCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [sphericalView setDataSource:self];
    [sphericalView setDelegate:self];
    [[self view] addSubview:sphericalView];
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UICollectioViewDelegate

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

- (void)collectionView:(UICollectionView *)cv didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return;
}

#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 22;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPSphericalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize retval = CGSizeMake(40, 40);
    return retval;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)cvl insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f);
}

@end
