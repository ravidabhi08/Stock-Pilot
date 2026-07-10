import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/search_result.dart';

/// Mock data source for stock search operations.
///
/// Provides a local, in-memory database of popular Indian stocks (NSE/BSE)
/// to simulate search API responses during development.
///
/// In a production environment, this would be replaced by a real API call
/// to a market data provider (e.g., Zerodha Kite Connect, Upstox) that
/// supports fuzzy search and autocomplete.
class MockSearchDatasource {
  /// The local database of popular Indian stocks.
  final List<SearchResult> _stockDatabase = [
    const SearchResult(
      symbol: 'RELIANCE',
      companyName: 'Reliance Industries Ltd.',
      exchange: 'NSE',
      sector: 'Energy',
    ),
    const SearchResult(
      symbol: 'TCS',
      companyName: 'Tata Consultancy Services Ltd.',
      exchange: 'NSE',
      sector: 'IT',
    ),
    const SearchResult(
      symbol: 'HDFCBANK',
      companyName: 'HDFC Bank Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(symbol: 'INFY', companyName: 'Infosys Ltd.', exchange: 'NSE', sector: 'IT'),
    const SearchResult(
      symbol: 'ICICIBANK',
      companyName: 'ICICI Bank Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'HINDUNILVR',
      companyName: 'Hindustan Unilever Ltd.',
      exchange: 'NSE',
      sector: 'FMCG',
    ),
    const SearchResult(symbol: 'ITC', companyName: 'ITC Ltd.', exchange: 'NSE', sector: 'FMCG'),
    const SearchResult(
      symbol: 'SBIN',
      companyName: 'State Bank of India',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'BHARTIARTL',
      companyName: 'Bharti Airtel Ltd.',
      exchange: 'NSE',
      sector: 'Telecom',
    ),
    const SearchResult(
      symbol: 'KOTAKBANK',
      companyName: 'Kotak Mahindra Bank Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'LT',
      companyName: 'Larsen & Toubro Ltd.',
      exchange: 'NSE',
      sector: 'Capital Goods',
    ),
    const SearchResult(
      symbol: 'AXISBANK',
      companyName: 'Axis Bank Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'ASIANPAINT',
      companyName: 'Asian Paints Ltd.',
      exchange: 'NSE',
      sector: 'Consumer Durables',
    ),
    const SearchResult(
      symbol: 'MARUTI',
      companyName: 'Maruti Suzuki India Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
    const SearchResult(
      symbol: 'TITAN',
      companyName: 'Titan Company Ltd.',
      exchange: 'NSE',
      sector: 'Consumer Durables',
    ),
    const SearchResult(
      symbol: 'SUNPHARMA',
      companyName: 'Sun Pharmaceutical Industries Ltd.',
      exchange: 'NSE',
      sector: 'Pharma',
    ),
    const SearchResult(
      symbol: 'ULTRACEMCO',
      companyName: 'UltraTech Cement Ltd.',
      exchange: 'NSE',
      sector: 'Cement',
    ),
    const SearchResult(
      symbol: 'BAJFINANCE',
      companyName: 'Bajaj Finance Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(symbol: 'WIPRO', companyName: 'Wipro Ltd.', exchange: 'NSE', sector: 'IT'),
    const SearchResult(
      symbol: 'TATAMOTORS',
      companyName: 'Tata Motors Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
    const SearchResult(
      symbol: 'ADANIENT',
      companyName: 'Adani Enterprises Ltd.',
      exchange: 'NSE',
      sector: 'Metals & Mining',
    ),
    const SearchResult(
      symbol: 'BAJAJ-AUTO',
      companyName: 'Bajaj Auto Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
    const SearchResult(
      symbol: 'HCLTECH',
      companyName: 'HCL Technologies Ltd.',
      exchange: 'NSE',
      sector: 'IT',
    ),
    const SearchResult(
      symbol: 'POWERGRID',
      companyName: 'Power Grid Corporation of India Ltd.',
      exchange: 'NSE',
      sector: 'Power',
    ),
    const SearchResult(symbol: 'NTPC', companyName: 'NTPC Ltd.', exchange: 'NSE', sector: 'Power'),
    const SearchResult(
      symbol: 'ONGC',
      companyName: 'Oil & Natural Gas Corporation Ltd.',
      exchange: 'NSE',
      sector: 'Energy',
    ),
    const SearchResult(
      symbol: 'TATASTEEL',
      companyName: 'Tata Steel Ltd.',
      exchange: 'NSE',
      sector: 'Metals & Mining',
    ),
    const SearchResult(
      symbol: 'JSWSTEEL',
      companyName: 'JSW Steel Ltd.',
      exchange: 'NSE',
      sector: 'Metals & Mining',
    ),
    const SearchResult(
      symbol: 'TECHM',
      companyName: 'Tech Mahindra Ltd.',
      exchange: 'NSE',
      sector: 'IT',
    ),
    const SearchResult(
      symbol: 'M&M',
      companyName: 'Mahindra & Mahindra Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
    const SearchResult(
      symbol: 'HDFCLIFE',
      companyName: 'HDFC Life Insurance Company Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'SBILIFE',
      companyName: 'SBI Life Insurance Company Ltd.',
      exchange: 'NSE',
      sector: 'Financial Services',
    ),
    const SearchResult(
      symbol: 'GRASIM',
      companyName: 'Grasim Industries Ltd.',
      exchange: 'NSE',
      sector: 'Diversified',
    ),
    const SearchResult(
      symbol: 'CIPLA',
      companyName: 'Cipla Ltd.',
      exchange: 'NSE',
      sector: 'Pharma',
    ),
    const SearchResult(
      symbol: 'DRREDDY',
      companyName: 'Dr. Reddy\'s Laboratories Ltd.',
      exchange: 'NSE',
      sector: 'Pharma',
    ),
    const SearchResult(
      symbol: 'EICHERMOT',
      companyName: 'Eicher Motors Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
    const SearchResult(
      symbol: 'DIVISLAB',
      companyName: 'Divi\'s Laboratories Ltd.',
      exchange: 'NSE',
      sector: 'Pharma',
    ),
    const SearchResult(
      symbol: 'COALINDIA',
      companyName: 'Coal India Ltd.',
      exchange: 'NSE',
      sector: 'Metals & Mining',
    ),
    const SearchResult(
      symbol: 'BPCL',
      companyName: 'Bharat Petroleum Corporation Ltd.',
      exchange: 'NSE',
      sector: 'Energy',
    ),
    const SearchResult(
      symbol: 'HEROMOTOCO',
      companyName: 'Hero MotoCorp Ltd.',
      exchange: 'NSE',
      sector: 'Automobile',
    ),
  ];

  /// Searches for stocks matching the given [query].
  ///
  /// Performs a case-insensitive search against both the company name
  /// and the stock symbol. Returns a list of matching [SearchResult] entities.
  Future<List<SearchResult>> searchStocks(String query) async {
    AppLogger.instance.d('🔍 MockSearchDatasource: Searching for "$query"...');

    // Simulate network delay (200-500ms) for realistic UX
    await Future.delayed(const Duration(milliseconds: 200));

    if (query.trim().isEmpty) {
      return [];
    }

    final String lowerCaseQuery = query.toLowerCase();

    // Filter the database based on symbol or company name
    final List<SearchResult> results =
        _stockDatabase.where((stock) {
          return stock.symbol.toLowerCase().contains(lowerCaseQuery) ||
              stock.companyName.toLowerCase().contains(lowerCaseQuery);
        }).toList();

    AppLogger.instance.d('🔍 MockSearchDatasource: Found ${results.length} results.');
    return results;
  }
}
