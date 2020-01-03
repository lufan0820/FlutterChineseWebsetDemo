/// * Create by lf 2020-01-03 16:52
/// Flutter动画简介
/// TODO Animation
/// Animation是一个抽象类，它本身和UI渲染没有任何关系，而它主要的动能是保存动画的差值和状态；
/// 其中一个比较常用的Animation类时Animation<double>。
/// Animation对象是一个在一段时间内依次生成一个区间(Tween)之间值的类。
/// Animation对象在整个动画执行过程中输出的值可以是线性的、曲线的、一个步进函数或者任何其他曲线函数等等，这有Curve来决定。
/// 根据Animation对象的控制方式，动画可以正向运行(从起始状态开始，到终止状态结束)，也可以反向运行，甚至可以在中间切换方向。
/// Animation还可以生成除double之外的其他类型值，如：Animation<Color>或Animation<Size>。
/// 在动画的每一帧中，我们可以通过Animation对象的value属性获取动画的当前状态值。
///
/// TODO 监听动画的通知:
/// addListener=> 它可以用于给Animation添加帧监听器，在每一帧都会被调用。帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建
/// addStatusListener=> 它可以给Animation添加“动画状态改变”监听器；动画开始、结束、正向或反向（见AnimationStatus定义）时会调用状态改变的监听器。
///
/// TODO Curve
/// 动画过程可以是匀速的、匀加速的或者先加速后减速等。
/// Flutter中通过Curve(曲线)来描述动画过程，我们把匀速动画称为线性的(Curve.linear)，而非匀速动画称为非线性。
/// 我们可以通过CurveAnimation来指定动画的曲线
/// CurvedAnimation和AnimationController（下面介绍）都是Animation<double>类型。
/// CurvedAnimation可以通过包装AnimationController和Curve生成一个新的动画对象 ，我们正是通过这种方式来将动画和动画执行的曲线关联起来的。
/// 我们指定动画的曲线为Curves.easeIn，它表示动画开始时比较慢，结束时比较快。
/// 具体参考: https://book.flutterchina.club/chapter9/intro.html
///
/// ```
/// 定义一个正弦曲线:
/// class ShakeCurve extends Curve {
///  @override
/// double transform(double t) {
///    return math.sin(t * math.PI * 2);
///  }
/// }
/// ```
///
/// TODO AnimationController
/// AnimationController用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法。
/// AnimationController派生自Animation<double>，因此可以在需要Animation对象的任何地方使用。
/// 但是，AnimationController具有控制动画的其他方法，例如forward()方法可以启动正向动画，reverse()可以启动反向动画。
///
/// TODO Ticker
/// 当创建一个AnimationController时，需要传递一个vsync参数，它接收一个TickerProvider类型的对象，它的主要职责是创建Ticker
/// Flutter应用在启动时都会绑定一个SchedulerBinding，通过SchedulerBinding可以给每一次屏幕刷新添加回调，
/// 而Ticker就是通过SchedulerBinding来添加屏幕刷新回调，这样一来，每次屏幕刷新都会调用TickerCallback。
/// 使用Ticker(而不是Timer)来驱动动画会防止屏幕外动画（动画的UI不在当前屏幕时，如锁屏时）消耗不必要的资源，
/// 因为Flutter中屏幕刷新时会通知到绑定的SchedulerBinding，而Ticker是受SchedulerBinding驱动的，
/// 由于锁屏后屏幕会停止刷新，所以Ticker就不会再触发。
/// 通常我们会将SingleTickerProviderStateMixin添加到State的定义中，然后将State对象作为vsync的值，这在后面的例子中可以见到。
///
/// TODO Tween
/// 默认情况下，AnimationController对象值的范围是[0.0，1.0]。如果我们需要构建UI的动画值在不同的范围或不同的数据类型，
/// 则可以使用Tween来添加映射以生成不同的范围或数据类型的值。
/// ```
/// Tween生成[-200.0，0.0]的值:
/// final Tween doubleTween = new Tween<double>(begin: -200.0, end: 0.0);
/// ```
/// Tween的唯一职责就是定义从输入范围到输出范围的映射。
///
/// TODO Tween.animate
/// 要使用Tween对象，需要调用其animate()方法，然后传入一个控制器对象
/// 注意animate()返回的是一个Animation，而不是一个Animatable
/// ```
/// 构建了一个控制器、一条曲线和一个Tween
/// final AnimationController controller = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
/// final Animation curve = new CurvedAnimation(parent: controller, curve: Curves.easeOut);
/// Animation<int> alpha = new IntTween(begin: 0, end: 255).animate(curve);
/// ```
