//
//  GifTableViewCell.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit
import Kingfisher

struct GifTableViewCellViewModel {
    let id: String
    let url: URL
    let title: String

    init(gif: GifObject) {
        id = gif.id
        title = gif.title
        url = gif.images.fixed_height.url
    }
}

class GifTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }

    func setup(with viewModel: GifTableViewCellViewModel) {
        imageView?.kf.setImage(with: viewModel.url)
        textLabel?.text = viewModel.title
    }
}
