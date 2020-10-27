//
//  DetailEventCoordinator.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 18/10/2020.
//

import UIKit
import CoreData

final class DetailEventCoordinator: Coordinator {
    
    private(set)  var childCoordinators: [Coordinator] = []
    
    private let naviagationCotroller: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    var onEditEvent: () -> Void = {}
    
    
    private let eventId: NSManagedObjectID
    
    init(naviagationCotroller: UINavigationController, eventId: NSManagedObjectID) {
        self.naviagationCotroller = naviagationCotroller
        self.eventId = eventId
    }
    
    func start() {
        let detailEventController: DetailEventViewController = .instanctiate()
        let eventDetailVM = EventDetailViewModel(id: eventId)
        self.onEditEvent = {
            eventDetailVM.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        eventDetailVM.coordinator = self
        detailEventController.eventDetailViewModel = eventDetailVM
        naviagationCotroller.pushViewController(detailEventController, animated: true)
    }
    
    func startEditEvent(with event: Event) {
        let editEventCoordinator = EditEventCoordinator(navigationController: naviagationCotroller, event: event)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    //    func onEditEvent() {
    //
    //    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
        
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
        
    }
}
