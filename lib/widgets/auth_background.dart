import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBackground extends StatelessWidget {

   final Widget child;

  const AuthBackground({
    Key? key,
    required this.child
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [

        const _PurpleFont(),
        const _HeaderIcon(),
        child,
        
      ],),


    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: SvgPicture.asset('assets/NUTRISALUD-NS.svg',color: Colors.white,),  

      ));
  }
}

class _PurpleFont extends StatelessWidget {
  const _PurpleFont({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;  

    return Container(
       height: size.height*0.4,
       width: double.infinity,
       decoration: _boxDecorationPur(),
       child: Stack (children: const[
          Positioned(child: _Bubble(), top: 90, left: 30 ),
          Positioned(child: _Bubble(), top: -40, left: -30 ),
          Positioned(child: _Bubble(), top: -50, right: -20 ),
          Positioned(child: _Bubble(), bottom: -50, left: 10 ),
          Positioned(child: _Bubble(), bottom: 120, right: 20 ),

       ],),
    );
  }

  BoxDecoration _boxDecorationPur() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors:[
          Color.fromRGBO(234, 24, 77, 1),
          Color.fromRGBO(180, 24, 77, 1)
          ],)
      );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}