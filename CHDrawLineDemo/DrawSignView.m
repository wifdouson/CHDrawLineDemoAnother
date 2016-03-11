//
//  DrawSignView.m
//  CHDrawLineDemo
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 hp. All rights reserved.
//
//
/**
 *
 *
 画板，因为用了UIBezierPath 所以，不会很耗手机内存，如果用UIGraphics draw方法，则会造成手机卡顿，很久之前做过那种方式，当时手机能跑几百M。
 思路：用UIBezierPath 画路径，然后生成上下文图片，并赋值给UIImageView进行展示，切记：UIBezierPath 汇出的只是路径，并不是在原油的uimage 的基础上绘图，所以之前的路径并不能一起展示，笔者之前就入坑了，尝试了各种方法；
 下边链接是标哥的博文，很好很强大
  http://www.henishuo.com/uibezierpath-draw/
 
 
 
 笔者的微博：http://weibo.com/chenscda
 github:https://github.com/chenhanqingdev
 *
 */

#import "DrawSignView.h"

typedef struct {
    CGPoint point;
    BOOL isOrignal;
}MyPointStruct;

@interface DrawSignView()
{
   
    
    UIImageView * globalImageView;

    UIImage * currentImage;
    NSMutableArray * pointArray;
    
}

@end
@implementation DrawSignView

- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        pointArray=[NSMutableArray new];
   
        globalImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:globalImageView];
        
  
        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    UIBezierPath * p=[UIBezierPath bezierPath];
    if ([pointArray count]<1) {
        return;
    }
    
    for (int i=0; i<pointArray.count; i++) {
        MyPointStruct thePointStruct;
        [[pointArray objectAtIndex:i] getValue:&thePointStruct];
       
        if (thePointStruct.isOrignal) {
            [p moveToPoint:thePointStruct.point];
        }else{
            [p addLineToPoint:thePointStruct.point];
        }
    }
    
  
    [[UIColor blueColor]set];
    [p stroke];
    globalImageView.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"touchesBegan");
    UITouch * touch=[touches anyObject];
    CGPoint currentPoint=[touch locationInView:self];
    MyPointStruct pStruct={currentPoint,YES};
    
    NSValue * pointValue=[NSValue valueWithBytes:&pStruct objCType:@encode(MyPointStruct)];
    ;
    [pointArray addObject:pointValue];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesMoved");
    UITouch * passTouch=[touches anyObject];
    CGPoint currentPoint=[passTouch locationInView:self];
    MyPointStruct pStruct={currentPoint,NO};
    NSValue * pointValue=[NSValue valueWithBytes:&pStruct objCType:@encode(MyPointStruct)];
    [pointArray addObject:pointValue];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");

}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesCancelled");

}


@end
