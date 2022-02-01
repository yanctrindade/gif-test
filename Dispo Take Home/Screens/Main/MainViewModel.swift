//
//  MainViewModel.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit

class MainViewModel {
    
    var apiClient = GifAPIClient()
    var dataFound: (() -> ())?
    var gifs: [GifObject] = []
    let CELL_HEIGHT:CGFloat = 80.0
    
    init() {}
    
    func getData() {
        apiClient.getTrendingGifs { [weak self] result in
            switch result {
            case .success(let gifs):
                self?.gifs = gifs
                self?.dataFound?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
