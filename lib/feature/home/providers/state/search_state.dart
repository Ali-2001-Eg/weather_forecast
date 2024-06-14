class SearchState {
  final bool isSearching;
  final String query;

  SearchState({required this.isSearching, required this.query});

  SearchState copyWith({bool? isSearching, String? query}) {
    return SearchState(
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
    );
  }
}
