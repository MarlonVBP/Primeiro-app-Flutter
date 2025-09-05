enum ConversionType {
  mToKm, kmToM,
  mToCm, cmToM,
  cmToInch, inchToCm,
  kmToMile, mileToKm,
  kToC, cToK,
  sToMin, minToS,
  sToH, hToS,
  sToDay, dayToS,
  dayToMonth, monthToDay,
  dayToYear, yearToDay,
}

class ConverterLogic {
  String _displayValue = '0';
  ConversionType _selectedType = ConversionType.mToKm;

  String get displayValue => _displayValue;
  ConversionType get selectedType => _selectedType;

  set selectedType(ConversionType type) {
    _selectedType = type;
    _updateResult();
  }

  String _resultValue = '';
  String get resultValue => _resultValue;

  void applyCommand(String command) {
    if (command == 'AC') {
      _clear();
    } else if (command == 'DEL') {
      _deleteDigit();
    } else {
      _addDigit(command);
    }
    _updateResult();
  }

  void _clear() {
    _displayValue = '0';
    _resultValue = '';
  }

  void _deleteDigit() {
    if (_displayValue.length > 1) {
      _displayValue = _displayValue.substring(0, _displayValue.length - 1);
    } else {
      _displayValue = '0';
    }
  }

  void _addDigit(String digit) {
    if (_displayValue.contains('.') && digit == '.') return;
    if (_displayValue == '0' && digit != '.') {
      _displayValue = digit;
    } else {
      _displayValue += digit;
    }
  }

  void _updateResult() {
    double? value = double.tryParse(_displayValue.replaceAll(',', '.'));
    if (value == null) {
      _resultValue = '';
      return;
    }
    switch (_selectedType) {
      case ConversionType.mToKm:
        _resultValue = (value / 1000).toStringAsFixed(6) + ' km';
        break;
      case ConversionType.kmToM:
        _resultValue = (value * 1000).toStringAsFixed(2) + ' m';
        break;
      case ConversionType.mToCm:
        _resultValue = (value * 100).toStringAsFixed(2) + ' cm';
        break;
      case ConversionType.cmToM:
        _resultValue = (value / 100).toStringAsFixed(6) + ' m';
        break;
      case ConversionType.cmToInch:
        _resultValue = (value / 2.54).toStringAsFixed(6) + ' in';
        break;
      case ConversionType.inchToCm:
        _resultValue = (value * 2.54).toStringAsFixed(2) + ' cm';
        break;
      case ConversionType.kmToMile:
        _resultValue = (value / 1.61).toStringAsFixed(6) + ' mi';
        break;
      case ConversionType.mileToKm:
        _resultValue = (value * 1.61).toStringAsFixed(6) + ' km';
        break;
      case ConversionType.kToC:
        _resultValue = (value - 273.15).toStringAsFixed(2) + ' °C';
        break;
      case ConversionType.cToK:
        _resultValue = (value + 273.15).toStringAsFixed(2) + ' K';
        break;
      case ConversionType.sToMin:
        _resultValue = (value / 60).toStringAsFixed(6) + ' min';
        break;
      case ConversionType.minToS:
        _resultValue = (value * 60).toStringAsFixed(2) + ' s';
        break;
      case ConversionType.sToH:
        _resultValue = (value / 3600).toStringAsFixed(6) + ' h';
        break;
      case ConversionType.hToS:
        _resultValue = (value * 3600).toStringAsFixed(2) + ' s';
        break;
      case ConversionType.sToDay:
        _resultValue = (value / 86400).toStringAsFixed(6) + ' dia(s)';
        break;
      case ConversionType.dayToS:
        _resultValue = (value * 86400).toStringAsFixed(2) + ' s';
        break;
      case ConversionType.dayToMonth:
        _resultValue = (value / 30).toStringAsFixed(6) + ' mês(es)';
        break;
      case ConversionType.monthToDay:
        _resultValue = (value * 30).toStringAsFixed(2) + ' dia(s)';
        break;
      case ConversionType.dayToYear:
        _resultValue = (value / 365).toStringAsFixed(6) + ' ano(s)';
        break;
      case ConversionType.yearToDay:
        _resultValue = (value * 365).toStringAsFixed(2) + ' dia(s)';
        break;
    }
  }
}