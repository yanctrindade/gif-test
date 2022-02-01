import UIKit

class MainViewController: UIViewController {
    
    var uiController = MainView()
    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = uiController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        setupTableView()
        viewModel.getData()
        viewModel.dataFound = { [weak self] in
            self?.refreshData()
        }
    }
    
    private func setupTableView() {
        uiController.tableView.delegate = self
        uiController.tableView.dataSource = self
        uiController.tableView.register(GifTableViewCell.self, forCellReuseIdentifier: GifTableViewCell.reuseIdentifier)
    }
    
    func refreshData() {
        uiController.tableView.reloadData()
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        searchBar.delegate = self
        return searchBar
    }()

}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: implement
    }
}

//MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.mainToDetail(searchResult: viewModel.selectedGif(indexPath: indexPath))
    }
    
}

//MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gifs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GifTableViewCell.reuseIdentifier, for: indexPath) as? GifTableViewCell else {
            fatalError("Failed to dequeue ImageTableViewCell")
        }
        cell.setup(with: GifTableViewCellViewModel(gif: viewModel.gifs[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.CELL_HEIGHT
    }
}
