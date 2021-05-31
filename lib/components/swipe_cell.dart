// 🐦 Flutter imports:
import 'package:flant/utils/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const double _kDismissThreshold = 0.5;
const Duration _kDismissDuration = Duration(milliseconds: 600);

typedef FlanSwipeCellBeforeClose = Future<bool> Function(
  FlanSwipeCellDetail detail,
);

class FlanSwipeCell extends StatefulWidget {
  const FlanSwipeCell({
    Key? key,
    this.name = '',
    this.leftWidth,
    this.rightWidth,
    this.beforeClose,
    this.disabled = false,
    this.onClick,
    this.onOpen,
    this.onClose,
    this.child,
    this.leftSlot,
    this.rightSlot,
  }) : super(key: key);

  // ****************** Props ******************

  final String name;

  final double? leftWidth;

  final double? rightWidth;

  final FlanSwipeCellBeforeClose? beforeClose;

  final bool disabled;

  // ****************** Events ******************

  final void Function(FlanSwipeCellPosition position)? onClick;

  final void Function(FlanSwipeCellDetail detail)? onOpen;

  final void Function(FlanSwipeCellDetail detail)? onClose;

  // ****************** Slots ******************

  final Widget? child;

  final Widget? leftSlot;

  final Widget? rightSlot;

  @override
  FlanSwipeCellState createState() => FlanSwipeCellState();
}

class FlanSwipeCellState extends State<FlanSwipeCell>
    with SingleTickerProviderStateMixin {
  late AnimationController _moveController;
  late Animation<double> _moveAnimation;

  bool _dragUnderway = false;
  double _dragExtent = 0.0;

  final GlobalKey _leftKey = GlobalKey();
  final GlobalKey _rightKey = GlobalKey();

  double _leftWidth = 0.0;
  double _rightWidth = 0.0;
  FlanSwipeCellPosition? _openPosition;

  @override
  void initState() {
    _moveController = AnimationController(
      vsync: this,
      duration: _kDismissDuration,
    );

    _updateMoveAnimation(true);
    nextTick(() {
      _computedLeftWidth();
      _computedRightWidth();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLeftSide(),
        _buildRightSide(),
        _buildCell(),
      ],
    );
  }

  Widget _buildCell() {
    return AnimatedBuilder(
      animation: _moveAnimation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(_moveAnimation.value, 0.0),
          child: child,
        );
      },
      child: IgnorePointer(
        ignoring: widget.disabled,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _onClick(FlanSwipeCellPosition.cell);
          },
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: _handleDragUpdate,
          onHorizontalDragEnd: _handleDragEnd,
          child: SizedBox(
            width: double.infinity,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildLeftSide() {
    return AnimatedBuilder(
      animation: _moveAnimation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: 0.0,
          bottom: 0.0,
          left: _moveAnimation.value - _leftWidth,
          child: child!,
        );
      },
      child: KeyedSubtree(
        key: _leftKey,
        child: Listener(
          onPointerUp: (_) {
            _onClick(FlanSwipeCellPosition.left);
          },
          child: widget.leftSlot ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildRightSide() {
    return AnimatedBuilder(
      animation: _moveAnimation,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
          top: 0.0,
          bottom: 0.0,
          right: -_moveAnimation.value - _rightWidth,
          child: child!,
        );
      },
      child: KeyedSubtree(
        key: _rightKey,
        child: Listener(
          onPointerUp: (_) {
            _onClick(FlanSwipeCellPosition.right);
          },
          child: widget.rightSlot ?? const SizedBox.shrink(),
        ),
      ),
    );
  }

  void open(FlanSwipeCellPosition position) {
    if (_isActive) {
      return;
    }

    void doAction() {
      _dragExtent = position == FlanSwipeCellPosition.left ? 1.0 : -1.0;
      setState(() {
        _updateMoveAnimation();
        _moveController.forward();
      });
    }

    if (_moveController.isCompleted) {
      if (_openPosition != position) {
        _moveController.reverse().then((_) => doAction());
      } else {
        doAction();
      }
    }
    if (_moveController.isDismissed) {
      doAction();
    }
    _openPosition = position; // 打开哪边
    _open(position);
  }

  void close(FlanSwipeCellPosition position) {
    if (_openPosition != null) {
      _moveController.reverse();
      _openPosition = null; // 还原
      _close(position);
    }
  }

  void _open(FlanSwipeCellPosition position) {
    widget.onOpen?.call(FlanSwipeCellDetail(widget.name, position));
  }

  void _close(FlanSwipeCellPosition position) {
    widget.onClose?.call(FlanSwipeCellDetail(widget.name, position));
  }

  void _onClick(FlanSwipeCellPosition position) {
    widget.onClick?.call(position);

    if (_openPosition != null) {
      if (widget.beforeClose != null) {
        widget.beforeClose
            ?.call(FlanSwipeCellDetail(widget.name, position))
            .then((bool flag) {
          if (flag) {
            close(position);
          }
        });
      } else {
        close(position);
      }
    }
  }

  bool get _isActive {
    return _dragUnderway || _moveController.isAnimating;
  }

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
    _dragExtent = _moveController.value * _bottomContentWidth * _dragExtentSign;
    if (_moveController.isAnimating) {
      _moveController.stop();
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController.isAnimating) {
      return;
    }

    final double delta = details.primaryDelta!;
    final double oldDragExtent = _dragExtent;
    _dragExtent += delta;

    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }
    if (!_moveController.isAnimating) {
      _moveController.value = _dragExtent.abs() / _bottomContentWidth;
    }
  }

  Future<void> _handleDragEnd(DragEndDetails details) async {
    if (!_isActive || _moveController.isAnimating) {
      return;
    }
    _dragUnderway = false;

    if (!_moveController.isDismissed) {
      _openPosition = null;
      if (_dragExtentSign > 0.0) {
        _openPosition = FlanSwipeCellPosition.left;
        _checkMoveEnd();
      }
      if (_dragExtentSign < 0.0) {
        _openPosition = FlanSwipeCellPosition.right;
        _checkMoveEnd();
      }
    }
  }

  void _checkMoveEnd() {
    final double threshold = _openPosition == FlanSwipeCellPosition.left
        ? 1 - _kDismissThreshold
        : _kDismissThreshold;

    if (_moveController.value > threshold) {
      _moveController.forward();
      _open(_openPosition!);
    } else {
      close(_openPosition!);
    }
  }

  double _computedLeftWidth() => _leftWidth =
      widget.leftWidth ?? _leftKey.currentContext?.size?.width ?? 0.0;

  double _computedRightWidth() => _rightWidth =
      widget.rightWidth ?? _rightKey.currentContext?.size?.width ?? 0.0;

  double get _dragExtentSign => _dragExtent.sign;

  double get _bottomContentWidth {
    if (_dragExtentSign > 0.0) {
      return _computedLeftWidth();
    }

    if (_dragExtentSign < 0.0) {
      return _computedRightWidth();
    }

    return 0.0;
  }

  void _updateMoveAnimation([bool isFirst = false]) {
    double width = 0.0;
    if (!isFirst) {
      width = _dragExtentSign * _bottomContentWidth;
    }

    _moveAnimation = _moveController.drive(
      Tween<double>(
        begin: 0.0,
        end: width,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
        DiagnosticsProperty<String>('name', widget.name, defaultValue: ''));
    properties.add(DiagnosticsProperty<double>('leftWidth', widget.leftWidth));
    properties
        .add(DiagnosticsProperty<double>('rightWidth', widget.rightWidth));
    properties.add(DiagnosticsProperty<FlanSwipeCellBeforeClose>(
        'beforeClose', widget.beforeClose));
    properties.add(DiagnosticsProperty<bool>('disabled', widget.disabled,
        defaultValue: false));
    super.debugFillProperties(properties);
  }
}

enum FlanSwipeCellPosition {
  left,
  right,
  cell,
}

class FlanSwipeCellDetail {
  FlanSwipeCellDetail(this.name, this.position);

  final String name;
  final FlanSwipeCellPosition position;
}
