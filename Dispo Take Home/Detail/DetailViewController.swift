import Combine
import UIKit

class DetailViewController: UIViewController {
  init(searchResult: SearchResult) {
    super.init(nibName: nil, bundle: nil)
    imageView.kf.setImage(with: searchResult.gifUrl)
    titleLabel.text = searchResult.text
    sharesLabel.text = "420 shares"
    tagsLabel.text = "Tags: camera, flash, whoops"
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .systemBackground
    view.addSubview(imageView)
    view.addSubview(titleLabel)
    view.addSubview(sharesLabel)
    view.addSubview(tagsLabel)

    imageView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
      $0.size.equalTo(view.snp.width).multipliedBy(0.8)
      $0.centerX.equalToSuperview()
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
    }

    sharesLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
    }

    tagsLabel.snp.makeConstraints {
      $0.top.equalTo(sharesLabel.snp.bottom).offset(15)
      $0.centerX.equalToSuperview()
    }
  }

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()

  private lazy var titleLabel = UILabel()

  private lazy var sharesLabel = UILabel()

  private lazy var tagsLabel = UILabel()

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
