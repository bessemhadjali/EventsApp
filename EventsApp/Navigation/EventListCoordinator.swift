//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 11/10/2020.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    var onUpdateEvent: () -> Void = {}
   // private var eventListViewModel: EventListViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
    
    func start() {
        let eventListViewController: EventListViewController = EventListViewController.instanctiate()
        let eventListViewModel = EventListViewModel()
        eventListViewModel.coordinator = self
        eventListViewController.eventListVM = eventListViewModel
        onUpdateEvent = {
            eventListViewModel.reload()
        }
    
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let detailEventCoordinator = DetailEventCoordinator(naviagationCotroller: navigationController, eventId: id)
        detailEventCoordinator.parentCoordinator = self
        childCoordinators.append(detailEventCoordinator)
        detailEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
                
    }
    
    
//    func onSaveEvent() {
//        eventListViewModel?.reload()
//    }
    
    
    
}
