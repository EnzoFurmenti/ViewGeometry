//
//  ViewController.m
//  ViewGeometry
//
//  Created by EnzoF on 24.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (strong, nonatomic) NSMutableDictionary *mDictionaryViews;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat indentedBGBlackRect = 5.f;
    CGFloat indentedBGWhiteRect = 7.f;
    CGFloat indentedBoard = 2.f;
    
    CGRect bgBlackRect = [self createMaxSquareInCentreParentView:self.view withIndented:indentedBGBlackRect];
    
    UIView *bgBlackView = [self addAndGetSubViewWithRect:bgBlackRect withBGColor:[UIColor blackColor] onParentView:self.view];
     [self.mDictionaryViews setObject:bgBlackView forKey:@"bgBlackView"];
    
    CGRect bgWhiteRect = [self createMaxSquareInCentreParentView:self.view withIndented:indentedBGWhiteRect];
    
    UIView *bgWhiteView = [self addAndGetSubViewWithRect:bgWhiteRect withBGColor:[UIColor whiteColor] onParentView:self.view];
    [self.mDictionaryViews setObject:bgBlackView forKey:@"bgWhiteView"];

    CGRect boardRect = [self createMaxSquareInCentreParentView:bgWhiteView withIndented:indentedBoard];
    
    CGFloat boardOriginX = CGRectGetMinX(boardRect);
    CGFloat boardOriginY = CGRectGetMinY(boardRect);
    CGFloat widthSquare =  CGRectGetWidth(boardRect) / 8;
    CGFloat heightSquare = CGRectGetHeight(boardRect) / 8;
    
    CGFloat x = 0.f;
    CGFloat y = 0.f;
    NSInteger positionSquare = 1;
    for(int row = 1;row <= 8;row++)
    {
        int startColumn = row % 2 ? 2 : 1;
        for(int column = startColumn;column <= 8;column = column + 2)
        {
            if(column == 1)
            {
                x = boardOriginX;
            }
            else
            {
                x = boardOriginX + widthSquare * (column - 1);
            }
            
            if(row == 1)
            {
                y = boardOriginY;
            }
            else
            {
                y = boardOriginY + heightSquare * (row - 1);
            }
            CGRect r = CGRectMake(x, y, widthSquare, heightSquare);
            UIView *squareView = [self addAndGetSubViewWithRect:r withBGColor:[UIColor blackColor] onParentView:bgWhiteView];
            NSString *keyString = [NSString stringWithFormat:@"Square-%lu",positionSquare];
            
            [self.mDictionaryViews setObject:squareView forKey: keyString];
            positionSquare++;
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -Initialization-

- (NSMutableDictionary*)mDictionaryViews{
    
    if(!_mDictionaryViews)
    {
        _mDictionaryViews = [[NSMutableDictionary alloc]init];
    }
    return _mDictionaryViews;
}

#pragma mark -UIViewController transition-
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    NSDictionary *dictExceptKey = [[NSDictionary alloc] initWithObjectsAndKeys:@"exceptView1",@"bgWhiteView", nil];
    [self changeBGColorOfViewsFromDictinary:self.mDictionaryViews exceptKeyView:dictExceptKey color:[self randomColor]];
}
#pragma mark -metods-

-(void)addSubViewWithRect:(CGRect)rect withBGColor:(UIColor*)color onParentView:(UIView*)parentView{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    [parentView addSubview:view];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin   |
                            UIViewAutoresizingFlexibleRightMargin  |
                            UIViewAutoresizingFlexibleTopMargin    |
                            UIViewAutoresizingFlexibleBottomMargin;
}

-(UIView*)addAndGetSubViewWithRect:(CGRect)rect withBGColor:(UIColor*)color onParentView:(UIView*)parentView{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = color;
    [parentView addSubview:view];
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin   |
    UIViewAutoresizingFlexibleRightMargin  |
    UIViewAutoresizingFlexibleTopMargin    |
    UIViewAutoresizingFlexibleBottomMargin;
    return view;
}
- (CGRect)createMaxSquareInCentreParentView:(UIView*)parentView withIndented:(CGFloat)indended{
    CGRect rectView = CGRectMake(parentView.bounds.origin.x, parentView.bounds.origin.y, parentView.bounds.size.width, parentView.bounds.size.height);
    if(!indended)
    {
        return rectView;
    }
    CGFloat rectViewMidX = CGRectGetMidX(rectView);
    CGFloat rectViewMidY = CGRectGetMidY(rectView);
    
    
    CGFloat widthRect = CGRectGetWidth(rectView) - 2 * indended;
    CGFloat heightRect = CGRectGetWidth(rectView) - 2 * indended;
    CGFloat rectOriginX = rectViewMidX - widthRect / 2;
    CGFloat rectOriginY = rectViewMidY - heightRect / 2;
    return CGRectMake(rectOriginX, rectOriginY, widthRect, heightRect);
}

-(void)changeBGColorOfViewsFromDictinary:(NSMutableDictionary*)mDictionaryViews  exceptKeyView:(NSDictionary*)keyViewDictionary color:(UIColor*)color{
    
    NSMutableDictionary *mDictionaryNonExceptionViews = [[NSMutableDictionary alloc] initWithDictionary:self.mDictionaryViews];
    
    for(NSString *currentKeyStr in self.mDictionaryViews.allKeys)
    {
        for (NSString *keyStr in keyViewDictionary.allKeys)
        {
            if([currentKeyStr isEqual:keyStr])
            {
                [mDictionaryNonExceptionViews removeObjectForKey:currentKeyStr];
            }
        }
    }
    for (UIView *currentView in mDictionaryNonExceptionViews.allValues)
    {
            currentView.backgroundColor = color;
    }
}

-(UIColor*)randomColor{
    return [[UIColor alloc] initWithRed:(float)(arc4random() % 100) / 100.f green:(float)(arc4random() % 100) / 100.f blue:(float)(arc4random() % 100) / 100.f alpha:(float)(arc4random() % 100) / 100.f];
}

@end
