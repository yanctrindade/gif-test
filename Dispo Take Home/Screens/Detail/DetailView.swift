//
//  DetailView.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    private let DEFAULT_IMGVIEW_HEIGHT = "100"
    private let DEFAULT_IMGVIEW_WIDTH = "100"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Text Information"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImageViewConstraints(widthStr: String?, heightStr: String?) {
        if let widthFormatter = NumberFormatter().number(from: widthStr ?? DEFAULT_IMGVIEW_WIDTH),
           let heightFormatter = NumberFormatter().number(from: heightStr ?? DEFAULT_IMGVIEW_HEIGHT) {
            let width = CGFloat(truncating: widthFormatter)
            let height = CGFloat(truncating: heightFormatter)
            
            imageView.snp.remakeConstraints() { make in
                make.centerY.equalTo(self).offset(-100)
                make.centerX.equalTo(self)
                make.height.equalTo(height)
                make.width.equalTo(width)
            }
            super.updateConstraints()
        }
    }
}

extension DetailView: RenderViewProtocol {
    
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(infoLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(-100)
            make.centerX.equalTo(self)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.centerX.equalTo(imageView.snp.centerX)
            make.right.equalTo(self).offset(24)
            make.left.equalTo(self).offset(-24)
        }
    }
    
    func additionalViewSetup() {
        backgroundColor = .white
    }
    
}
