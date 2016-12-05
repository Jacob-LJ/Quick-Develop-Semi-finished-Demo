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

## case14: Crash_In_beforeiOS10_reloadDataAndlayoutAttributesForSupplementaryViewOfKind/atIndexPath
### iOS10之前系统, 当CollectionView 调用 reloadData 时遇上layoutAttributesForSupplementaryViewOfKind:atIndexPath时崩溃问题 总结测试model
####warning    1:iOS10之前系统, 当CollectionView 调用 reloadData 时(在不太确定的时间范围内)即刻调用layoutAttributesForSupplementaryViewOfKind:atIndexPath时 会 崩溃
####warning    2:iOS10之前系统, 当CollectionView 先调用layoutAttributesForSupplementaryViewOfKind:atIndexPath 时即刻调用reloadData时 不会 崩溃
####warning    3:一般在界面加载时候回默认进行一次collectionView的 reloadData, 所以在此期间要确保不要调用 layoutAttributesForSupplementaryViewOfKind:atIndexPath 方法

## case15 (PopRightItemMenuViewDemo): 右上角 pop 出 menuView 
### 学习点: anchorPoint 及 position 对动画影响
####参考Demo : https://github.com/KongPro/PopMenuTableView (Commits on Nov 18, 2016版本)
####对参考 Demo 修改的地方解析:
####1> 将类方法调用 改为 实例方法调用, 因为源事例通过类方法调用在内部是通过 View.tag 进行获取对应的的 menuView 实例进行的, 这样当项目层级复杂情况下, 难以维护View.tag值的唯一性
####2> 对源码中 anchorPoint 及 position 的处理简化, 源代码中作者处理 anchorPoint 和 position 的方法感觉看上去并未完全理解这两个 layer 属性的真正含义; 参考文章: http://wonderffee.github.io/blog/2013/10/13/understand-anchorpoint-and-position/
![image](https://github.com/Jacob-LJ/Quick-Develop-Semi-finished-Demo/raw/master/Pics/PopRightItemMenuViewDemo.gif)

##case16 (layer_property_learning,学习iOS-Core-Animation-Advanced-Techniques的demo)
#### iOS-Core-Animation-Advanced-Techniques链接 https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques/blob/master
