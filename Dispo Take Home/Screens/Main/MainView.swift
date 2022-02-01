//
//  MainView.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit

class MainView: UIView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "search gifs..."
        return searchBar
    }()

}

extension MainView: RenderViewProtocol {
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func additionalViewSetup() {
        backgroundColor = .systemBackground
    }
    
}
