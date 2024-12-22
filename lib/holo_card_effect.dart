library;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class HoloCard extends StatefulWidget {
  final String imageUrl;
  final double width;
  final double height;
  final bool showGlitter;
  final bool showHolo;
  final bool showRainbow;
  final bool showShadow;
  final bool showGloss;

  const HoloCard({
    super.key,
    required this.imageUrl,
    this.width = 300,
    this.height = 420,
    this.showGlitter = true,
    this.showHolo = true,
    this.showRainbow = true,
    this.showShadow = true,
    this.showGloss = true,
  });

  // URLかどうかを判定するヘルパーメソッド
  bool get isNetworkImage {
    return imageUrl.startsWith('http://') ||
        imageUrl.startsWith('https://') ||
        imageUrl.startsWith('data:');
  }

  @override
  State<HoloCard> createState() => _HoloCardState();
}

class _HoloCardState extends State<HoloCard> {
  double _rotationX = 0;
  double _rotationY = 0;
  double _rotationZ = 0;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final screenSize = MediaQuery.of(context).size;
      final centerX = screenSize.width / 2;
      final centerY = screenSize.height / 2;

      final dx = details.globalPosition.dx - centerX;
      final dy = details.globalPosition.dy - centerY;

      _rotationY = (dx / centerX * 35).clamp(-35, 35);
      _rotationX = (dy / centerY * 35).clamp(-35, 35);
      _rotationZ = (dx * dy / (centerX * centerY) * 20).clamp(-20, 20);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _rotationX = 0;
      _rotationY = 0;
      _rotationZ = 0;
    });
  }

  Widget _buildGlossEffect() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            -0.2 - (_rotationY / 35),
            -0.2 - (_rotationX / 35),
          ),
          end: Alignment(
            0.2 - (_rotationY / 35),
            0.2 - (_rotationX / 35),
          ),
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(
              ((_rotationY.abs() + _rotationX.abs()) / 70) * 0.7,
            ),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.2, 0.5, 0.8],
        ),
      ),
    );
  }

  Widget _buildPlasticGlossEffect() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            -1.0 - (_rotationY / 35),
            -1.0 - (_rotationX / 35),
          ),
          end: Alignment(
            1.0 - (_rotationY / 35),
            1.0 - (_rotationX / 35),
          ),
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(
              ((_rotationY.abs() + _rotationX.abs()) / 70) * 0.3,
            ),
            Colors.white.withOpacity(
              ((_rotationY.abs() + _rotationX.abs()) / 70) * 0.6,
            ),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.3, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildEdgeHighlight() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(
            ((_rotationY.abs() + _rotationX.abs()) / 70) * 0.5,
          ),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
        gradient: RadialGradient(
          center: Alignment(
            (_rotationY / 35),
            (_rotationX / 35),
          ),
          focal: Alignment(
            (_rotationY / 70),
            (_rotationX / 70),
          ),
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(
              ((_rotationY.abs() + _rotationX.abs()) / 70) * 0.2,
            ),
          ],
          stops: const [0.8, 1.0],
        ),
      ),
    );
  }

  Widget _buildGlitterEffect() {
    return Opacity(
      opacity: 0.3 * ((_rotationY.abs() + _rotationX.abs()) / 70),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment(
            -1 + (_rotationY / 35),
            -1 + (_rotationX / 35),
          ),
          end: Alignment(
            1 + (_rotationY / 35),
            1 + (_rotationX / 35),
          ),
        ).createShader(bounds),
        blendMode: BlendMode.overlay,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.1),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(bounds),
          blendMode: BlendMode.plus,
          child: Image.asset(
            'assets/sparkles.gif',
            package: 'holo_card_effect',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }

  Widget _buildHoloEffect() {
    return Opacity(
      opacity: 0.7 * ((_rotationY.abs() + _rotationX.abs()) / 70),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            Colors.white.withOpacity(0.0),
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment(
            -1 + (_rotationY / 35),
            -1 + (_rotationX / 35),
          ),
          end: Alignment(
            1 + (_rotationY / 35),
            1 + (_rotationX / 35),
          ),
        ).createShader(bounds),
        blendMode: BlendMode.screen,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.5),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(bounds),
          blendMode: BlendMode.overlay,
          child: Image.asset(
            'assets/holo.png',
            package: 'holo_card_effect',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.7),
            colorBlendMode: BlendMode.hardLight,
          ),
        ),
      ),
    );
  }

  Widget _buildRainbowEffect() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          const Color(0xFFff0084)
              .withOpacity(0.35 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
          const Color(0xFFfca400)
              .withOpacity(0.3 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
          const Color(0xFFffff00)
              .withOpacity(0.25 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
          const Color(0xFF00ff8a)
              .withOpacity(0.25 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
          const Color(0xFF00cfff)
              .withOpacity(0.3 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
          const Color(0xFFcc4cfa)
              .withOpacity(0.35 * ((_rotationY.abs() + _rotationX.abs()) / 70)),
        ],
        begin: Alignment(
          -1.2 + (_rotationY / 35),
          -1.2 + (_rotationX / 35),
        ),
        end: Alignment(
          1.2 + (_rotationY / 35),
          1.2 + (_rotationX / 35),
        ),
      ).createShader(bounds),
      blendMode: BlendMode.overlay,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(
              (_rotationY / 35),
              (_rotationX / 35),
            ),
            focal: Alignment(
              (_rotationY / 70),
              (_rotationX / 70),
            ),
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.transparent,
            ],
            stops: const [0.0, 0.9],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotationX * math.pi / 180)
          ..rotateY(_rotationY * math.pi / 180)
          ..rotateZ(_rotationZ * math.pi / 180),
        alignment: Alignment.center,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: widget.showShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Color.lerp(
                        const Color(0xFFfac),
                        const Color(0xFFddccaa),
                        0.5,
                      )!
                          .withOpacity(0.3),
                      blurRadius: 45,
                      spreadRadius: -8,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: const Color(0xFFfac).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(-15, -15),
                    ),
                    BoxShadow(
                      color: const Color(0xFFddccaa).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: -5,
                      offset: const Offset(15, 15),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 60,
                      spreadRadius: -10,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                widget.isNetworkImage
                    ? Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Image.asset(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                if (widget.showGloss) ...[
                  _buildGlossEffect(),
                  _buildPlasticGlossEffect(),
                ],
                _buildEdgeHighlight(),
                if (widget.showGlitter) _buildGlitterEffect(),
                if (widget.showHolo) _buildHoloEffect(),
                if (widget.showRainbow) _buildRainbowEffect(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
