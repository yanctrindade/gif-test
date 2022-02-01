import UIKit

class DetailViewController: UIViewController {
    
    var uiController: DetailView
    var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
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
        viewModel.getGifById()
        viewModel.updateUI = { [weak self] in
            self?.updateUI()
        }
    }
    
    func updateUI() {
        uiController.imageView.kf.setImage(with: viewModel.gifFound?.images.fixed_height.url)
        uiController.updateImageViewConstraints(widthStr: viewModel.gifFound?.images.fixed_height.width,
                                                heightStr: viewModel.gifFound?.images.fixed_height.height)
        uiController.infoLabel.text = viewModel.getGifInfo()
    }
    
}
