import Kingfisher
import UIKit

class SearchResultCell: UICollectionViewCell {
  func configure(searchResult: SearchResult) {
    imageView.kf.setImage(with: searchResult.gifUrl)
    label.text = searchResult.text
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    contentView.addSubview(label)

    imageView.snp.makeConstraints {
      $0.size.equalTo(60)
      $0.left.top.bottom.equalToSuperview().inset(10)
    }

    label.snp.makeConstraints {
      $0.left.equalTo(imageView.snp.right).offset(15)
      $0.right.equalToSuperview().inset(15)
      $0.centerY.equalToSuperview()
    }
  }

  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()

  private lazy var label = UILabel()

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
