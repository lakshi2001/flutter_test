import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

enum SearchState {
initial, 
loading, 
success, 
error, 
empty 
}

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService;

  SearchState _state = SearchState.initial;
  List<String> _results = [];
  String _errorMessage = '';

  SearchState get state => _state;
  List<String> get results => _results;
  String get errorMessage => _errorMessage;

  final BehaviorSubject<String> _querySubject = BehaviorSubject<String>();

  SearchProvider({SearchService? searchService})
    : _searchService = searchService ?? SearchService() {
    _querySubject
        .debounceTime(const Duration(milliseconds: 300))
        .distinct() 
        .switchMap((query) {
         
          _state = SearchState.loading;
          notifyListeners();

          if (query.isEmpty) {
           
            _state = SearchState.empty;
            _results = [];
            notifyListeners();
            return Stream.value([]);
          }

       
          return Stream.fromFuture(_searchService.searchProducts(query))
              .doOnError((error, stackTrace) {
                _state = SearchState.error;
                _errorMessage = error.toString();
                notifyListeners();
              })
              .handleError((error) {
                _state = SearchState.error;
                _errorMessage = 'An error occurred';
                notifyListeners();
              });
        })
        .listen((products) {
          _state = products.isEmpty ? SearchState.empty : SearchState.success;
          _results = products.cast<String>(); 
          notifyListeners();
        });
  }


  void updateSearchQuery(String query) {
    _querySubject.add(query);
  }

  @override
  void dispose() {
    _querySubject.close(); 
    super.dispose();
  }
}
