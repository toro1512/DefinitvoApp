import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri_saludapp/themes/app_theme.dart';

class DatosMedidas extends StatelessWidget {
  final int indice;
  final String valorPedir;
  final String labelMedida;
  const DatosMedidas({
    Key? key, 
    required this.indice,
    required this.valorPedir,
    required this.labelMedida
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Text(valorPedir)),
            Expanded(
              flex: 2,
              child: TextFormField(
                          inputFormatters: [
                           FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,3})?\.?\d{0,2}'))
                          ],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primary)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintStyle: TextStyle(fontSize: 16, color: Colors.grey[300], )
                          ),
                          
                    
                        ),
              ),
            Expanded(
              flex: 1,child: Text('  '+labelMedida))

          ]
        ),
      ),
    );
  }
}