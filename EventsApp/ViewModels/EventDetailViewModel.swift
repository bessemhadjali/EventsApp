//
//  EventDetailViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 18/10/2020.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    private let id: NSManagedObjectID
    private var eventService: EventServiceProtocol
    private var event: Event?
    var onUpadate: () -> Void = {}
    var coordinator: DetailEventCoordinator?
    init(id: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
        self.id = id
        self.eventService = eventService
    }
    
    var backgroundImage: UIImage? {
        guard let imageData = event?.image, let image = UIImage(data: imageData) else { return nil }
        return image
    }
    
    var eventName: String? {
        event?.name
    }
    
    var date: String {
        guard let eventDate = event?.date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var timeRemainingVM: TimeRemainingViewModel? {
        guard let eventDate = event?.date, let timeRemainingStrings =  Date().timeRemaining(until: eventDate)?.components(separatedBy: ",") else {
            return nil
            
        }
        
        //        var timeRemainingString = ""
        //        timeRemainingStrings?.forEach {
        //            timeRemainingString += "\($0)\n"
        //        }
        
        return TimeRemainingViewModel(timeRemainingStrings: timeRemainingStrings)
    }
    
    
    func getEvent() {
        reload()
       
    }
    
    func reload()  {
        guard let event = eventService.getEvent(id) else { return }
        self.event = event
        
        onUpadate()
    }
    
    func didDisappear() {
        coordinator?.didFinish()
    }
    
    @objc func editButtonTapped() {
        guard let event = event else {
            return
        }
        coordinator?.startEditEvent(with: event)
//        coordinator?.onEditEvent = {
//            self.onUpadate()
//        }
    }
}
