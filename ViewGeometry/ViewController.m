//
//  ViewController.m
//  ViewGeometry
//
//  Created by EnzoF on 24.08.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "ViewController.h"
typedef enum{
        ViewControllerBackgroundViewFirstType = 10,
        ViewControllerBackgroundViewSecondType = 20,
        ViewControllerSquareViewType = 100,
        ViewControllerDraughtViewType = 200
}ViewControllerTypeView;

@interface ViewController ()


@property (strong, nonatomic) NSMutableDictionary *mDictionaryViews;
@property (strong,nonatomic) UIView *boardView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat indentedBGBlackRect = 5.f;
    CGFloat indentedBGWhiteRect = 10.f;
    CGFloat indentedBoard = 4.f;
    CGFloat indentedDraught = 15.f;
   if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
   {
       indentedDraught = 7.5f;
   }
   
       
   if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
   {
       indentedDraught = 20.f;
   }
    CGRect bgBlackRect = [self createMaxSquareInCentreParentView:self.view withIndented:indentedBGBlackRect];
    
    UIView *bgBlackView = [self addAndGetSubViewWithRect:bgBlackRect withBGColor:[UIColor blackColor] onParentView:self.view];
    bgBlackView.tag = 10;
     [self.mDictionaryViews setObject:bgBlackView forKey:@"bgBlackView"];
    
    CGRect bgWhiteRect = [self createMaxSquareInCentreParentView:self.view withIndented:indentedBGWhiteRect];
    
    UIView *bgWhiteView = [self addAndGetSubViewWithRect:bgWhiteRect withBGColor:[UIColor whiteColor] onParentView:self.view];
    bgWhiteView.tag = 20;
    self.boardView = bgWhiteView;
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
            NSString *keyString = [NSString stringWithFormat:@"Square-%ld",(long)positionSquare];
            squareView.tag = 100;
            [self.mDictionaryViews setObject:squareView forKey: keyString];
            positionSquare++;
        }
    }
    
    CGFloat draughtOriginX = boardOriginX + indentedDraught;
    CGFloat draughtOriginY = boardOriginY + indentedDraught;
    CGFloat widthDraught=  CGRectGetWidth(boardRect) / 8 - 2 * indentedDraught;
    CGFloat heightDraught = CGRectGetHeight(boardRect) / 8  - 2 * indentedDraught;
    
    int positionDraught = 1;
    for(int row = 1;row <= 8;row++)
    {
        if(row > 3 & row < 6)
        {
            continue;
        }
        int startColumn = 0;
        UIColor *colorDraught = [UIColor whiteColor];
        if(row <= 3)
        {
            startColumn = row % 2 ? 2 : 1;
        }
        if(row >=6)
        {
            startColumn = row % 2 ? 1 : 2;
            colorDraught = [UIColor redColor];
        }
        
        for(int column = startColumn;column <= 8;column = column + 2)
        {
            
            if(column == 1)
            {
                x = draughtOriginX;
            }
            else
            {
                x = draughtOriginX +(widthDraught  + 2 * indentedDraught) * (column - 1);
            }
            
            if(row == 1)
            {
                y = draughtOriginY;
                
            }
            else
            {
                y = draughtOriginY + (heightDraught + 2 * indentedDraught) * (row - 1);
            }
            
            CGRect r = CGRectMake(x, y, widthDraught, heightDraught);
            UIView *draughtView = [self addAndGetSubViewWithRect:r withBGColor:colorDraught onParentView:bgWhiteView];
            draughtView.tag = 200;
            NSString *keyString = [NSString stringWithFormat:@"Draught-%d",positionDraught];
            [self.mDictionaryViews setObject:draughtView forKey: keyString];
            positionDraught++;
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
    NSDictionary *dictExceptKey = [[NSDictionary alloc]
                                   initWithObjectsAndKeys:
                                   @"eV1",@"bgWhiteView",
                                   @"eV2",@"Draught-1",
                                   @"eV3",@"Draught-2",
                                   @"eV4",@"Draught-3",
                                   @"eV5",@"Draught-4",
                                   @"eV6",@"Draught-5",
                                   @"eV7",@"Draught-6",
                                   @"eV8",@"Draught-7",
                                   @"eV9",@"Draught-8",
                                   @"eV10",@"Draught-9",
                                   @"eV11",@"Draught-10",
                                   @"eV12",@"Draught-11",
                                   @"eV13",@"Draught-12",
                                   @"eV14",@"Draught-13",
                                   @"eV15",@"Draught-14",
                                   @"eV16",@"Draught-15",
                                   @"eV17",@"Draught-16",
                                   @"eV18",@"Draught-17",
                                   @"eV19",@"Draught-18",
                                   @"eV20",@"Draught-19",
                                   @"eV21",@"Draught-20",
                                   @"eV22",@"Draught-21",
                                   @"eV23",@"Draught-22",
                                   @"eV24",@"Draught-23",
                                   @"eV25",@"Draught-24", nil];
    [self changeBGColorOfViewsFromDictionary:self.mDictionaryViews
                               exceptKeyView:dictExceptKey
                                       color:[self randomColor]];
    
    [self shuffleDraught];
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
    
    CGFloat widthRect;
    CGFloat heightRect;
    if(CGRectGetWidth(rectView) > CGRectGetHeight(rectView))
    {
        widthRect = CGRectGetHeight(rectView) - 2 * indended;
        heightRect = CGRectGetHeight(rectView) - 2 * indended;
    }
    else
    {
        widthRect = CGRectGetWidth(rectView) - 2 * indended;
        heightRect = CGRectGetWidth(rectView) - 2 * indended;
    }
    CGFloat rectOriginX = rectViewMidX - widthRect / 2;
    CGFloat rectOriginY = rectViewMidY - heightRect / 2;
    return CGRectMake(rectOriginX, rectOriginY, widthRect, heightRect);
}

-(void)changeBGColorOfViewsFromDictionary:(NSMutableDictionary*)mDictionaryViews  exceptKeyView:(NSDictionary*)keyViewDictionary color:(UIColor*)color{
    
    NSMutableDictionary *mDictionaryNonExceptionViews = [[NSMutableDictionary alloc] initWithDictionary:mDictionaryViews];
    
    for(NSString *currentKeyStr in mDictionaryViews.allKeys)
    {
        for (NSString *keyExceptionStr in keyViewDictionary.allKeys)
        {
            if([currentKeyStr isEqual:keyExceptionStr])
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

- (void)shuffleDraught{
    NSUInteger count = [self.boardView.subviews count];
    for( int currentIndex = 0;currentIndex < count;currentIndex++)
    {
        NSInteger randomIndex = arc4random() % [self.boardView.subviews count];
        UIView *view1 = [self.boardView.subviews objectAtIndex:currentIndex];
        UIView *view2 = [self.boardView.subviews objectAtIndex:randomIndex];
        if(view1.tag != ViewControllerDraughtViewType | view2.tag != ViewControllerDraughtViewType)
        {
            continue;
        }
        if([view1 isEqual:view2])
        {
            continue;
        }
        CGRect frame1 = view1.frame;
        CGRect frame2 =view2.frame;
        
        view1.frame = frame2;
        view2.frame = frame1;
        
        [self.boardView exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:randomIndex];
    }
}
@end
