//
//  DetailView.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit

class DetailView: UIView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailView: RenderViewProtocol {
    
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func additionalViewSetup() {
        
    }
    
}
