//
//  EventService.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 21/10/2020.
//

import UIKit
import CoreData

// to help us for mock in unit test
protocol EventServiceProtocol {
    func perform(eventAction: EventService.EventAction, eventDataInput: EventService.EventDataInput)
    func getEvents() -> [Event]
    func getEvent(_ id: NSManagedObjectID) -> Event?
}

final class EventService: EventServiceProtocol {
    
    enum EventAction {
        case add
        case update(Event)
    }
    
    struct EventDataInput {
        let name: String
        let date: Date
        let image: UIImage
    }
    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    
    func perform(eventAction: EventAction, eventDataInput: EventDataInput) {
        let event: Event
        switch eventAction {
        case .add:
            event = Event(context: coreDataManager.context)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }
        
        event.setValue(eventDataInput.name, forKey: "name")
        let reseizedImage = eventDataInput.image.sameAspectRatio(newHeight: 250)
        let imageData = reseizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(eventDataInput.date, forKey: "date")
        coreDataManager.save()

    
        }
        
    func getEvents() -> [Event] {
        return coreDataManager.getAll()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        return coreDataManager.get(with: id)
    }
        
}
