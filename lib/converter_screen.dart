import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'converter_logic.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final logic = ConverterLogic();

  final Color bgGradientStart = Color(0xFF283593); // Azul escuro
  final Color bgGradientEnd = Color(0xFF512DA8);   // Roxo escuro
  final Color accentColor = Color(0xFFFF9800);     // Laranja
  final Color keyboardBg = Color(0xFF3949AB);      // Azul médio
  final Color buttonBg = Color(0xFF5C6BC0);        // Azul claro
  final Color displayBg = Colors.white;
  final Color displayText = Color(0xFF283593);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: accentColor,
        title: Text(
          'Conversor de Unidades',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [bgGradientStart, bgGradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 12),
            _buildDropdown(logic),
            SizedBox(height: 12),
            _buildDisplay(logic),
            Divider(height: 0.1, color: Colors.white70),
            _buildKeyboard(logic),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(ConverterLogic logic) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButton<ConversionType>(
        value: logic.selectedType,
        dropdownColor: bgGradientEnd,
        iconEnabledColor: accentColor,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        isExpanded: true,
        underline: SizedBox(),
        items: [
          DropdownMenuItem(child: Text('Metros → Quilômetros'), value: ConversionType.mToKm),
          DropdownMenuItem(child: Text('Quilômetros → Metros'), value: ConversionType.kmToM),
          DropdownMenuItem(child: Text('Metros → Centímetros'), value: ConversionType.mToCm),
          DropdownMenuItem(child: Text('Centímetros → Metros'), value: ConversionType.cmToM),
          DropdownMenuItem(child: Text('Centímetros → Polegadas'), value: ConversionType.cmToInch),
          DropdownMenuItem(child: Text('Polegadas → Centímetros'), value: ConversionType.inchToCm),
          DropdownMenuItem(child: Text('Quilômetros → Milhas'), value: ConversionType.kmToMile),
          DropdownMenuItem(child: Text('Milhas → Quilômetros'), value: ConversionType.mileToKm),
          DropdownMenuItem(child: Text('Kelvin → Celsius'), value: ConversionType.kToC),
          DropdownMenuItem(child: Text('Celsius → Kelvin'), value: ConversionType.cToK),
          DropdownMenuItem(child: Text('Segundos → Minutos'), value: ConversionType.sToMin),
          DropdownMenuItem(child: Text('Minutos → Segundos'), value: ConversionType.minToS),
          DropdownMenuItem(child: Text('Segundos → Horas'), value: ConversionType.sToH),
          DropdownMenuItem(child: Text('Horas → Segundos'), value: ConversionType.hToS),
          DropdownMenuItem(child: Text('Segundos → Dias'), value: ConversionType.sToDay),
          DropdownMenuItem(child: Text('Dias → Segundos'), value: ConversionType.dayToS),
          DropdownMenuItem(child: Text('Dias → Meses'), value: ConversionType.dayToMonth),
          DropdownMenuItem(child: Text('Meses → Dias'), value: ConversionType.monthToDay),
          DropdownMenuItem(child: Text('Dias → Anos'), value: ConversionType.dayToYear),
          DropdownMenuItem(child: Text('Anos → Dias'), value: ConversionType.yearToDay),
        ],
        onChanged: (type) {
          setState(() {
            logic.selectedType = type!;
          });
        },
      ),
    );
  }

  Widget _buildDisplay(ConverterLogic logic) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: displayBg.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AutoSizeText(
              logic.displayValue,
              minFontSize: 28.0,
              maxFontSize: 80.0,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: displayText,
              ),
            ),
            SizedBox(height: 16),
            AutoSizeText(
              logic.resultValue,
              minFontSize: 24.0,
              maxFontSize: 60.0,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboard(ConverterLogic logic) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: keyboardBg.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 320.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('7', logic: logic),
                _buildKeyboardButton('8', logic: logic),
                _buildKeyboardButton('9', logic: logic),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('4', logic: logic),
                _buildKeyboardButton('5', logic: logic),
                _buildKeyboardButton('6', logic: logic),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('1', logic: logic),
                _buildKeyboardButton('2', logic: logic),
                _buildKeyboardButton('3', logic: logic),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('0', flex: 2, logic: logic),
                _buildKeyboardButton('.', logic: logic),
                _buildKeyboardButton('DEL', textColor: accentColor, logic: logic),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildKeyboardButton('AC', textColor: accentColor, logic: logic),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(String label, {int flex = 1, Color textColor = Colors.white, required ConverterLogic logic}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: _HoverButton(
          label: label,
          textColor: textColor,
          buttonBg: buttonBg,
          accentColor: accentColor,
          onPressed: () {
            setState(() {
              logic.applyCommand(label);
            });
          },
        ),
      ),
    );
  }
}

// Botão customizado com efeito de hover, sombra e borda
class _HoverButton extends StatefulWidget {
  final String label;
  final Color textColor;
  final Color buttonBg;
  final Color accentColor;
  final VoidCallback onPressed;

  const _HoverButton({
    required this.label,
    required this.textColor,
    required this.buttonBg,
    required this.accentColor,
    required this.onPressed,
  });

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = _isHovered
        ? widget.buttonBg.withOpacity(0.8)
        : widget.buttonBg;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? widget.accentColor : Colors.white24,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: _isHovered ? 12 : 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.onPressed,
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: widget.textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}