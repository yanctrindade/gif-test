//
//  MainViewModel.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit

class MainViewModel {
    
    private var apiClient = GifAPIClient()
    var dataFound: (() -> ())?
    var gifs: [GifObject] = []
    let CELL_HEIGHT:CGFloat = 80.0
    var searchText: String?
    
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
    
    func selectedGif(indexPath: IndexPath)-> SearchResult {
        let gifSelected = gifs[indexPath.row]
        return SearchResult(id: gifSelected.id, gifUrl: gifSelected.url, title: gifSelected.title)
    }
    
    func searchGifByText() {
        guard let text = searchText else {
            return
        }
        guard !text.isEmpty else {
            getData()
            return
        }
        apiClient.searchGifByText(text) { [weak self] result in
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
