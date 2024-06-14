import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state/search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState(isSearching: false, query: ''));

  void startSearch() {
    state = state.copyWith(isSearching: true);
  }

  void stopSearch() {
    state = state.copyWith(isSearching: false,);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
  }
  void removeQuery() {
    state = state.copyWith(query: '');
  }
}
