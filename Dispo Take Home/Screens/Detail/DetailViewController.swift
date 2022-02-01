import UIKit

class DetailViewController: UIViewController {
    
    var uiController: DetailView
    
    init(searchResult: SearchResult) {
        uiController = DetailView()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = uiController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
