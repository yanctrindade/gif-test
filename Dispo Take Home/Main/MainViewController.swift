import Combine
import UIKit

class MainViewController: UIViewController {
  private var results: [SearchResult] = []

  private var cancellables = Set<AnyCancellable>()
  private let cellTappedSubject = PassthroughSubject<SearchResult, Never>()
  private let searchTextChangedSubject = PassthroughSubject<String, Never>()
  private let viewWillAppearSubject = PassthroughSubject<Void, Never>()

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.titleView = searchBar

    let (
      loadResults,
      pushDetailView
    ) = mainViewModel(
      cellTapped: cellTappedSubject.eraseToAnyPublisher(),
      searchText: searchTextChangedSubject.eraseToAnyPublisher(),
      viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher()
    )

    loadResults
      .sink { [weak self] results in
        self?.results = results
        self?.collectionView.reloadData()
      }
      .store(in: &cancellables)

    pushDetailView
      .sink { [weak self] result in
        self?.navigationController?.pushViewController(
          DetailViewController(searchResult: result),
          animated: true
        )
      }
      .store(in: &cancellables)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewWillAppearSubject.send()
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)

    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "search gifs..."
    searchBar.delegate = self
    return searchBar
  }()

  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(layoutSize: .init(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(80)
        ))
        let group = NSCollectionLayoutGroup.vertical(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(80)
          ),
          subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
      })
    )
    collectionView.backgroundColor = .clear
    collectionView.keyboardDismissMode = .onDrag
    collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchTextChangedSubject.send(searchText)
  }
}

// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    results.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "cell",
      for: indexPath
    ) as? SearchResultCell else {
      fatalError()
    }
    let result = results[indexPath.item]
    cell.configure(searchResult: result)
    return cell
  }
}

// MARK: UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    cellTappedSubject.send(results[indexPath.item])
  }
}
