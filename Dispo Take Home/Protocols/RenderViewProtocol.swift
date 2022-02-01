//
//  RenderViewProtocol.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import Foundation

protocol RenderViewProtocol {
    func buildViewHierarchy()
    func setupConstraints()
    func additionalViewSetup()
}

extension RenderViewProtocol {
    func setupViews() {
        buildViewHierarchy()
        setupConstraints()
        additionalViewSetup()
    }
}
