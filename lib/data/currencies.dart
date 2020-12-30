import 'package:app/model/full_currency.dart';

// TODO https://transferwise.com/gb/blog/world-currency-symbols

/* Fully supported Currencies (exchange rates and formatting)
CAD
HKD
ISK
PHP
DKK
HUF
CZK
GBP
RON
SEK
IDR
INR
BRL
RUB
HRK
JPY
THB
CHF
EUR
MYR
BGN
TRY
CNY
NOK
NZD
ZAR
USD
MXN
SGD
AUD
ILS
KRW
PLN
*/
// TODO Fill in all symbols
final fullCurrencies = {
  'AED':
      FullCurrency(code: 'AED', name: 'UAE Dirham', minorDigits: 2, symbol: ''),
  'AFN': FullCurrency(code: 'AFN', name: 'Afghani', minorDigits: 2),
  'ALL': FullCurrency(code: 'ALL', name: 'Lek', minorDigits: 2),
  'AMD': FullCurrency(code: 'AMD', name: 'Armenian Dram', minorDigits: 2),
  'ANG': FullCurrency(
      code: 'ANG', name: 'Netherlands Antillean Guilder', minorDigits: 2),
  'AOA': FullCurrency(code: 'AOA', name: 'Kwanza', minorDigits: 2),
  'ARS': FullCurrency(code: 'ARS', name: 'Argentine Peso', minorDigits: 2),
  'AUD': FullCurrency(code: 'AUD', name: 'Australian Dollar', minorDigits: 2),
  'AWG': FullCurrency(code: 'AWG', name: 'Aruban Florin', minorDigits: 2),
  'AZN': FullCurrency(code: 'AZN', name: 'Azerbaijanian Manat', minorDigits: 2),
  'BAM': FullCurrency(code: 'BAM', name: 'Convertible Mark', minorDigits: 2),
  'BBD': FullCurrency(code: 'BBD', name: 'Barbados Dollar', minorDigits: 2),
  'BDT': FullCurrency(code: 'BDT', name: 'Taka', minorDigits: 2),
  'BGN': FullCurrency(code: 'BGN', name: 'Bulgarian Lev', minorDigits: 2),
  'BHD': FullCurrency(code: 'BHD', name: 'Bahraini Dinar', minorDigits: 3),
  'BIF': FullCurrency(code: 'BIF', name: 'Burundi Franc', minorDigits: 0),
  'BMD': FullCurrency(code: 'BMD', name: 'Bermudian Dollar', minorDigits: 2),
  'BND': FullCurrency(code: 'BND', name: 'Brunei Dollar', minorDigits: 2),
  'BOB': FullCurrency(code: 'BOB', name: 'Boliviano', minorDigits: 2),
  'BRL': FullCurrency(code: 'BRL', name: 'Brazilian Real', minorDigits: 2),
  'BSD': FullCurrency(code: 'BSD', name: 'Bahamian Dollar', minorDigits: 2),
  'BTC': FullCurrency(code: 'BTC', name: 'Bitcoin', minorDigits: 5),
  'BTN': FullCurrency(code: 'BTN', name: 'Ngultrum', minorDigits: 2),
  'BWP': FullCurrency(code: 'BWP', name: 'Pula', minorDigits: 2),
  'BZD': FullCurrency(code: 'BZD', name: 'Belize Dollar', minorDigits: 2),
  'CAD': FullCurrency(code: 'CAD', name: 'Canadian Dollar', minorDigits: 2),
  'CDF': FullCurrency(code: 'CDF', name: 'Congolese Franc', minorDigits: 2),
  'CHF': FullCurrency(code: 'CHF', name: 'Swiss Franc', minorDigits: 2),
  'CLP': FullCurrency(code: 'CLP', name: 'Chilean Peso', minorDigits: 0),
  'CNY': FullCurrency(
      code: 'CNY', name: 'Yuan Renminbi', minorDigits: 2, symbol: '¥'),
  'COP': FullCurrency(code: 'COP', name: 'Colombian Peso', minorDigits: 2),
  'CRC': FullCurrency(code: 'CRC', name: 'Costa Rican Colon', minorDigits: 2),
  'CUC': FullCurrency(code: 'CUC', name: 'Peso Convertible', minorDigits: 2),
  'CUP': FullCurrency(code: 'CUP', name: 'Cuban Peso', minorDigits: 2),
  'CVE': FullCurrency(code: 'CVE', name: 'Cabo Verde Escudo', minorDigits: 2),
  'CZK': FullCurrency(code: 'CZK', name: 'Czech Koruna', minorDigits: 2),
  'DJF': FullCurrency(code: 'DJF', name: 'Djibouti Franc', minorDigits: 0),
  'DKK': FullCurrency(code: 'DKK', name: 'Danish Krone', minorDigits: 2),
  'DOP': FullCurrency(code: 'DOP', name: 'Dominican Peso', minorDigits: 2),
  'DZD': FullCurrency(code: 'DZD', name: 'Algerian Dinar', minorDigits: 2),
  'EGP': FullCurrency(code: 'EGP', name: 'Egyptian Pound', minorDigits: 2),
  'ERN': FullCurrency(code: 'ERN', name: 'Nakfa', minorDigits: 2),
  'ETB': FullCurrency(code: 'ETB', name: 'Ethiopian Birr', minorDigits: 2),
  'EUR': FullCurrency(code: 'EUR', name: 'Euro', minorDigits: 2, symbol: '€'),
  'FJD': FullCurrency(code: 'FJD', name: 'Fiji Dollar', minorDigits: 2),
  'FKP':
      FullCurrency(code: 'FKP', name: 'Falkland Islands Pound', minorDigits: 2),
  'GBP': FullCurrency(
      code: 'GBP', name: 'Pound Sterling', minorDigits: 2, symbol: '£'),
  'GEL': FullCurrency(code: 'GEL', name: 'Lari', minorDigits: 2),
  'GHS': FullCurrency(code: 'GHS', name: 'Ghana Cedi', minorDigits: 2),
  'GIP': FullCurrency(code: 'GIP', name: 'Gibraltar Pound', minorDigits: 2),
  'GMD': FullCurrency(code: 'GMD', name: 'Dalasi', minorDigits: 2),
  'GNF': FullCurrency(code: 'GNF', name: 'Guinea Franc', minorDigits: 0),
  'GTQ': FullCurrency(code: 'GTQ', name: 'Quetzal', minorDigits: 2),
  'GYD': FullCurrency(code: 'GYD', name: 'Guyana Dollar', minorDigits: 2),
  'HKD': FullCurrency(code: 'HKD', name: 'Hong Kong Dollar', minorDigits: 2),
  'HNL': FullCurrency(code: 'HNL', name: 'Lempira', minorDigits: 2),
  'HRK': FullCurrency(code: 'HRK', name: 'Croatian Kuna', minorDigits: 2),
  'HTG': FullCurrency(code: 'HTG', name: 'Gourde', minorDigits: 2),
  'HUF': FullCurrency(code: 'HUF', name: 'Forint', minorDigits: 2),
  'IDR': FullCurrency(code: 'IDR', name: 'Rupiah', minorDigits: 2),
  'ILS': FullCurrency(code: 'ILS', name: 'New Israeli Sheqel', minorDigits: 2),
  'INR': FullCurrency(
      code: 'INR', name: 'Indian Rupee', minorDigits: 2, symbol: '₹'),
  'IQD': FullCurrency(code: 'IQD', name: 'Iraqi Dinar', minorDigits: 3),
  'IRR': FullCurrency(code: 'IRR', name: 'Iranian Rial', minorDigits: 2),
  'ISK': FullCurrency(code: 'ISK', name: 'Iceland Krona', minorDigits: 0),
  'JMD': FullCurrency(code: 'JMD', name: 'Jamaican Dollar', minorDigits: 2),
  'JOD': FullCurrency(code: 'JOD', name: 'Jordanian Dinar', minorDigits: 3),
  'JPY': FullCurrency(code: 'JPY', name: 'Yen', minorDigits: 0, symbol: '¥'),
  'KES': FullCurrency(code: 'KES', name: 'Kenyan Shilling', minorDigits: 2),
  'KGS': FullCurrency(code: 'KGS', name: 'Som', minorDigits: 2),
  'KHR': FullCurrency(code: 'KHR', name: 'Riel', minorDigits: 2),
  'KMF': FullCurrency(code: 'KMF', name: 'Comoro Franc', minorDigits: 0),
  'KPW': FullCurrency(code: 'KPW', name: 'North Korean Won', minorDigits: 2),
  'KRW': FullCurrency(code: 'KRW', name: 'Won', minorDigits: 0, symbol: '₩'),
  'KWD': FullCurrency(code: 'KWD', name: 'Kuwaiti Dinar', minorDigits: 3),
  'KYD':
      FullCurrency(code: 'KYD', name: 'Cayman Islands Dollar', minorDigits: 2),
  'KZT': FullCurrency(code: 'KZT', name: 'Tenge', minorDigits: 2),
  'LAK': FullCurrency(code: 'LAK', name: 'Kip', minorDigits: 2),
  'LBP': FullCurrency(code: 'LBP', name: 'Lebanese Pound', minorDigits: 2),
  'LKR': FullCurrency(code: 'LKR', name: 'Sri Lanka Rupee', minorDigits: 2),
  'LRD': FullCurrency(code: 'LRD', name: 'Liberian Dollar', minorDigits: 2),
  'LSL': FullCurrency(code: 'LSL', name: 'Loti', minorDigits: 2),
  'LYD': FullCurrency(code: 'LYD', name: 'Libyan Dinar', minorDigits: 3),
  'MAD': FullCurrency(code: 'MAD', name: 'Moroccan Dirham', minorDigits: 2),
  'MDL': FullCurrency(code: 'MDL', name: 'Moldovan Leu', minorDigits: 2),
  'MGA': FullCurrency(code: 'MGA', name: 'Malagasy Ariary', minorDigits: 2),
  'MKD': FullCurrency(code: 'MKD', name: 'Denar', minorDigits: 2),
  'MMK': FullCurrency(code: 'MMK', name: 'Kyat', minorDigits: 2),
  'MNT': FullCurrency(code: 'MNT', name: 'Tugrik', minorDigits: 2),
  'MOP': FullCurrency(code: 'MOP', name: 'Pataca', minorDigits: 2),
  'MRO': FullCurrency(code: 'MRO', name: 'Ouguiya', minorDigits: 2),
  'MUR': FullCurrency(code: 'MUR', name: 'Mauritius Rupee', minorDigits: 2),
  'MVR': FullCurrency(code: 'MVR', name: 'Rufiyaa', minorDigits: 2),
  'MWK': FullCurrency(code: 'MWK', name: 'Kwacha', minorDigits: 2),
  'MXN': FullCurrency(code: 'MXN', name: 'Mexican Peso', minorDigits: 2),
  'MYR': FullCurrency(code: 'MYR', name: 'Malaysian Ringgit', minorDigits: 2),
  'MZN': FullCurrency(code: 'MZN', name: 'Mozambique Metical', minorDigits: 2),
  'NAD': FullCurrency(code: 'NAD', name: 'Namibia Dollar', minorDigits: 2),
  'NGN': FullCurrency(code: 'NGN', name: 'Naira', minorDigits: 2),
  'NIO': FullCurrency(code: 'NIO', name: 'Cordoba Oro', minorDigits: 2),
  'NOK': FullCurrency(code: 'NOK', name: 'Norwegian Krone', minorDigits: 2),
  'NPR': FullCurrency(code: 'NPR', name: 'Nepalese Rupee', minorDigits: 2),
  'NZD': FullCurrency(code: 'NZD', name: 'New Zealand Dollar', minorDigits: 2),
  'OMR': FullCurrency(code: 'OMR', name: 'Rial Omani', minorDigits: 3),
  'PAB': FullCurrency(code: 'PAB', name: 'Balboa', minorDigits: 2),
  'PEN': FullCurrency(code: 'PEN', name: 'Nuevo Sol', minorDigits: 2),
  'PGK': FullCurrency(code: 'PGK', name: 'Kina', minorDigits: 2),
  'PHP': FullCurrency(code: 'PHP', name: 'Philippine Peso', minorDigits: 2),
  'PKR': FullCurrency(code: 'PKR', name: 'Pakistan Rupee', minorDigits: 2),
  'PLN': FullCurrency(code: 'PLN', name: 'Zloty', minorDigits: 2),
  'PYG': FullCurrency(code: 'PYG', name: 'Guarani', minorDigits: 0),
  'QAR': FullCurrency(code: 'QAR', name: 'Qatari Rial', minorDigits: 2),
  'RON': FullCurrency(code: 'RON', name: 'New Romanian Leu', minorDigits: 2),
  'RSD': FullCurrency(code: 'RSD', name: 'Serbian Dinar', minorDigits: 2),
  'RUB': FullCurrency(
      code: 'RUB', name: 'Russian Ruble', minorDigits: 2, symbol: '₽'),
  'RWF': FullCurrency(code: 'RWF', name: 'Rwanda Franc', minorDigits: 0),
  'SAR': FullCurrency(code: 'SAR', name: 'Saudi Riyal', minorDigits: 2),
  'SBD':
      FullCurrency(code: 'SBD', name: 'Solomon Islands Dollar', minorDigits: 2),
  'SCR': FullCurrency(code: 'SCR', name: 'Seychelles Rupee', minorDigits: 2),
  'SDG': FullCurrency(code: 'SDG', name: 'Sudanese Pound', minorDigits: 2),
  'SEK': FullCurrency(code: 'SEK', name: 'Swedish Krona', minorDigits: 2),
  'SGD': FullCurrency(code: 'SGD', name: 'Singapore Dollar', minorDigits: 2),
  'SHP': FullCurrency(code: 'SHP', name: 'Saint Helena Pound', minorDigits: 2),
  'SLL': FullCurrency(code: 'SLL', name: 'Leone', minorDigits: 2),
  'SOS': FullCurrency(code: 'SOS', name: 'Somali Shilling', minorDigits: 2),
  'SRD': FullCurrency(code: 'SRD', name: 'Surinam Dollar', minorDigits: 2),
  'STD': FullCurrency(code: 'STD', name: 'Dobra', minorDigits: 2),
  'SVC': FullCurrency(code: 'SVC', name: 'El Salvador Colon', minorDigits: 2),
  'SYP': FullCurrency(code: 'SYP', name: 'Syrian Pound', minorDigits: 2),
  'SZL': FullCurrency(code: 'SZL', name: 'Lilangeni', minorDigits: 2),
  'THB': FullCurrency(code: 'THB', name: 'Baht', minorDigits: 2),
  'TJS': FullCurrency(code: 'TJS', name: 'Somoni', minorDigits: 2),
  'TMT':
      FullCurrency(code: 'TMT', name: 'Turkmenistan New Manat', minorDigits: 2),
  'TND': FullCurrency(code: 'TND', name: 'Tunisian Dinar', minorDigits: 3),
  'TOP': FullCurrency(code: 'TOP', name: 'Pa’anga', minorDigits: 2),
  'TRY': FullCurrency(
      code: 'TRY', name: 'Turkish Lira', minorDigits: 2, symbol: '₺'),
  'TTD': FullCurrency(
      code: 'TTD', name: 'Trinidad and Tobago Dollar', minorDigits: 2),
  'TWD': FullCurrency(code: 'TWD', name: 'New Taiwan Dollar', minorDigits: 2),
  'TZS': FullCurrency(code: 'TZS', name: 'Tanzanian Shilling', minorDigits: 2),
  'UAH': FullCurrency(code: 'UAH', name: 'Hryvnia', minorDigits: 2),
  'UGX': FullCurrency(code: 'UGX', name: 'Uganda Shilling', minorDigits: 0),
  'USD': FullCurrency(code: 'USD', name: 'US Dollar', minorDigits: 2),
  'UYU': FullCurrency(code: 'UYU', name: 'Peso Uruguayo', minorDigits: 2),
  'UZS': FullCurrency(code: 'UZS', name: 'Uzbekistan Sum', minorDigits: 2),
  'VEF': FullCurrency(code: 'VEF', name: 'Bolivar', minorDigits: 2),
  'VND': FullCurrency(code: 'VND', name: 'Dong', minorDigits: 0),
  'VUV': FullCurrency(code: 'VUV', name: 'Vatu', minorDigits: 0),
  'WST': FullCurrency(code: 'WST', name: 'Tala', minorDigits: 2),
  'XAF': FullCurrency(code: 'XAF', name: 'CFA Franc BEAC', minorDigits: 0),
  'XCD':
      FullCurrency(code: 'XCD', name: 'East Caribbean Dollar', minorDigits: 2),
  'XOF': FullCurrency(code: 'XOF', name: 'CFA Franc BCEAO', minorDigits: 0),
  'XPF': FullCurrency(code: 'XPF', name: 'CFP Franc', minorDigits: 0),
  'YER': FullCurrency(code: 'YER', name: 'Yemeni Rial', minorDigits: 2),
  'ZAR': FullCurrency(code: 'ZAR', name: 'Rand', minorDigits: 2),
  'ZMW': FullCurrency(code: 'ZMW', name: 'Zambian Kwacha', minorDigits: 2),
  'ZWL': FullCurrency(code: 'ZWL', name: 'Zimbabwe Dollar', minorDigits: 2),
};
