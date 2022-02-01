//
//  DetailViewModel.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import Foundation

class DetailViewModel {
    let apiClient = GifAPIClient()
    let gifId: String
    var updateUI: (() -> ())?
    
    var gifFound: GifObject?
    
    init(searchResult: SearchResult) {
        gifId = searchResult.id
    }
    
    func getGifById() {
        apiClient.getGifById(gifId) { [weak self] result in
            switch result {
            case .success(let gif):
                self?.gifFound = gif
                self?.updateUI?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getGifInfo()-> String? {
        var content: String?
        if let title = gifFound?.title {
            content = "Title: \(title)"
        }
        if let source_tld = gifFound?.source_tld {
            content?.append("\n\nSource: \(source_tld)")
        }
        if let rating = gifFound?.rating {
            content?.append("\n\nRating: \(rating)")
        }
        return content
    }
}
