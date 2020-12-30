export 'package:flutter/material.dart';

export 'package:preferences/preferences.dart';

export 'package/yasm.dart';

export 'util/formatting.dart';
export 'util/datetime.dart';

import 'package:preferences/preferences.dart';

String get primaryCurrency => PrefService.get('primaryCurrency') ?? 'USD';
set primaryCurrency(String str) =>
    PrefService.setString('primaryCurrency', str);

String get formattingPattern =>
    PrefService.get('formattingPattern') ?? 'S###,###,###.00';
set formattingPattern(String str) =>
    PrefService.setString('formattingPattern', str);

String get customSeperator => PrefService.get('customSeperator');
set customSeperator(String str) =>
    PrefService.setString('customSeperator', str);

bool get invertSeperators => PrefService.get('invertSeperators') ?? false;
set invertSeperators(bool val) => PrefService.setBool('invertSeperators', val);

int maxTransactionsShownPerCat = 2;
