# Quick-Develop-Semi-finished-Demo
用于快速开发用的半成品参考 demo
场景练习记录

## case1 : 顶部悬停+collectionView sectionHeaders指定位置悬停
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/case1.gif)


## case2 : case2-简单collectionView的header和footer悬浮
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/CollectionView-SimpleStickyHeaderFooter.gif)


## case3 : 效果集(有空再拆开成小 demo 2016-10-16)
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/case3.gif)

## case4 : xib的简单collectionView
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/case4.png)

## case5 : Predicate 谓词的基本使用介绍

## case6 : collectionView 滚动Item顺滑居中及比例缩放CenterAndScaleItemCollectionDemo
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/CenterAndScaleItemCollectionDemo.gif)
一行显示很多的Icon，并且距中心点越近的Icon,尺寸越大；距离中心点越远的Icon，尺寸逐渐变小。而且在滚动过程中，也是这种效果。

## case7 : collectionView 滚动Item顺滑居中(使用的是 UIScrollViewDelegate 方法)centerItemSmoothWithScrollViewDelegateMethord

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset

![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/centerItemSmoothWithScrollViewDelegateMethord.gif)

## case8 : 不同数据源切换CollectionView维持对应的位置效果
###需要补充说明
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/keepPositon.gif)

## case9 : 简单进度条画法
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/ProgressIndicator.gif)

## case10 : segmentControl 单个按钮颜色自定义
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/segmentControlSetdifferentColor.gif)

## case11 : ScrollableAndZoomOutHeaderDemo 可放大且滚动的BannerHeaderView
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/ScrollableAndZoomOutHeaderDemo.gif)


## case12 : ScrollableAndZoomOutHeaderDemo 仿网易新闻栏目拖动重排添加删除效果
###参考文章: http://www.huangyibiao.com/archives/1337
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/movingItemLikeNetEasyNewsDemo.gif)

## case13 :在类的初始化方法中应该直接调用实例变量
### 通过 setter 方法在父类中置nil,子类 复写了 setter 方法的 子类 SmithPerson 创建的时候就会报错, 所以"不应该在 init 或 dealloc 方法中调用 getter&setter 方法,而应该直接使用实例变量进行初始化赋值"

## case14 : transitonParallaxDemo
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/transitionParralaxDemo.gif)
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/transitionParralaxCompare.gif)
###fixed
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/transitonParallaxDemo_naibar___leftItemPositionAndBarTintColorFixed.gif)

