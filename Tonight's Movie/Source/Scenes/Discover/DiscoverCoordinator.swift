//
//  DiscoverCoordinator.swift
//  Tonight's Movie
//
//  Created by Maxime Maheo on 06/08/2018.
//  Copyright (c) 2018 Maxime Maheo. All rights reserved.
//

import Foundation
import UIKit

class DiscoverCoordinator: Coordinator {
    
    // MARK: - Properties -
    var children: [Coordinator]
    
    private let navigationController: UINavigationController
    
    // MARK: - Lifecycle -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.children = []
    }

    // MARK: - Methods -
    func start() {
        let interactor = DiscoverInteractor()
        let presenter = DiscoverPresenter(interactor: interactor, coordinator: self)
        let viewController = DiscoverViewController.instantiate(with: presenter)

        interactor.output = presenter
        presenter.output = viewController

        navigationController.setViewControllers([viewController], animated: false)
    }
}

// PRESENTER -> COORDINATOR
extension DiscoverCoordinator: DiscoverCoordinatorInput {
    func showDetailsOfMovie(movieId: Int) {
        let coordinator = MovieDetailsCoordinator(navigationController: navigationController)
        children.append(coordinator)
        coordinator.start()
    }
}
