//
//  AppCoordinator.swift
//  Dispo Take Home
//
//  Created by Yan Correa Trindade on 01/02/22.
//

import UIKit

class AppCoordinator {
    
    private var presenter: UINavigationController
    private var window: UIWindow
    private weak var appDelegate: AppDelegate?
    
    init(appDelegate: AppDelegate, window: UIWindow) {
        self.appDelegate = appDelegate
        self.window = window
        self.presenter = UINavigationController()
    }
    
    func start() {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
        self.presenter = UINavigationController(rootViewController: mainViewController)
        self.appDelegate?.window = self.window
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    func mainToDetail(searchResult: SearchResult) {
        let viewModel = DetailViewModel(searchResult: searchResult)
        let detailVC = DetailViewController(viewModel: viewModel)
        presenter.pushViewController(detailVC, animated: true)
    }
    
}


