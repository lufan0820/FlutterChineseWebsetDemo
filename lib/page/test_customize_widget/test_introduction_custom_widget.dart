/// * Create by lf 2020-01-09 10:42
/// 自定义组件方法简介
/// Flutter中自定义组件有三种方式: 通过组合其他组件、自绘、实现RenderObject
///
/// TODO 组合其他组件
/// 这种方式是通过拼接其他组件来组合成一个新的组件。
/// Container就是一个组合组件，它是由DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组成。
///
/// TODO 自绘
/// 如果遇到无法通过现有的组件来实现需要的UI时，我们可以通过自绘组件的方式来实现，例如我们需要一个颜色渐变的圆形进度条，
/// 而Flutter提供的CircularProgressIndicator并不支持在显示精确进度时对进度条应用渐变色(其valueColor属性只支持执行旋转动画时变化indicator的颜色)，
/// 这时最好的方法就是通过自定义组件来绘制出我们期望的外观。
/// 我们可以通过Flutter中提供的CustomPaint和Canvas来实现UI自绘。
///
/// TODO 实现RenderObject
/// Flutter提供的自身具有UI外观的组件，如文本Text、Image都是通过相应的RenderObject渲染出来的，如Text是有RenderParagraph渲染；
/// 而Image是由RenderImage渲染。RenderObject是一个抽象类，它定义了一个抽象方法paint(PaintingContext context,Offset offset)
/// PaintingContext 代表组件绘制的上下文，通过PaintingContext.canvas可以获得canvas，而绘制逻辑主要通过CanvasAPI 来实现。
/// 子类需要重写此方法来实现自身的逻辑绘制，如RenderParagraph需要实现文本绘制逻辑，而RenderImage 需要实现图片绘制逻辑。
///
/// 可以发现，RenderObject中最终也也是通过Canvas API来绘制的，那么通过实现RenderObject的方式和上面介绍的通过CustomPaint和Canvas自绘的方式有什么区别呢？
/// CustomPaint只是为了方便开发者封装的一个代理类，它直接继承自SingleChildRenderObjectWidget，通过RenderCustomPaint的paint方法将Canvas和画笔Painter
/// 连接起来实现了最终的绘制(绘制逻辑在Painter中)。
///
/// TODO 总结
/// '组合'是自定义组件最简单的方法，在任何需要自定义组件的场景下，我们都应该优先考虑是否能够通过组合来实现。
/// 而自绘和通过实现RenderObject的方法本质上是一样的，都需要开发者调用CanvasAPI手动去绘制UI，优点是强大灵活，理论上可以实现任何外观的UI，
/// 而缺点是必须了解Canvas API的细节，并且得自己去实现绘制逻辑。
