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
        setupTableView()
        setupSearchBar()
        viewModel.getData()
        viewModel.dataFound = { [weak self] in
            self?.refreshData()
        }
    }
    
    private func setupSearchBar() {
        navigationItem.titleView = uiController.searchBar
        uiController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        uiController.tableView.delegate = self
        uiController.tableView.dataSource = self
        uiController.tableView.register(GifTableViewCell.self, forCellReuseIdentifier: GifTableViewCell.reuseIdentifier)
    }
    
    func refreshData() {
        uiController.tableView.reloadData()
    }

}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
    }
    
    @objc func reload() {
        print("search method called")
        viewModel.searchGifByText()
    }
}

//MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.mainToDetail(searchResult: viewModel.selectedGif(indexPath: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
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
