import Combine
import UIKit

func mainViewModel(
  cellTapped: AnyPublisher<SearchResult, Never>,
  searchText: AnyPublisher<String, Never>,
  viewWillAppear: AnyPublisher<Void, Never>
) -> (
  loadResults: AnyPublisher<[SearchResult], Never>,
  pushDetailView: AnyPublisher<SearchResult, Never>
) {
  let api = TenorAPIClient.live

  let featuredGifs = viewWillAppear
    .first()
    .flatMap { api.featuredGIFs() }

  let searchResults = searchText
    .map { api.searchGIFs($0) }
    .switchToLatest()

  let loadResults = Publishers
    .CombineLatest3(
      searchText.prepend(""),
      searchResults,
      featuredGifs
    )
    .map { query, searchResults, featured in
      query.isEmpty ? featured : searchResults
    }
    .eraseToAnyPublisher()

  let pushDetailView = cellTapped

  return (
    loadResults: loadResults,
    pushDetailView: pushDetailView
  )
}
