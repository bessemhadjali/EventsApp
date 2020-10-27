//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 12/10/2020.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    
    var coordinator: EventListCoordinator?
    var onUpdate: () -> Void = {}
    
    private(set) var cells: [EventCellViewModel] = []
    private var eventService: EventServiceProtocol
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func loadCells() {
        reload()
    }
    
    func reload() {
        EventCellViewModel.imageCache.removeAllObjects()
        cells = eventService.getEvents().map {
            var eventCellViewModel: EventCellViewModel
            eventCellViewModel = EventCellViewModel(event: $0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return eventCellViewModel
           
        }
        onUpdate()
    }
    var rows: Int {
        cells.count
    }
    
    func cell(for indexPath: IndexPath) -> EventCellViewModel {
        return cells[indexPath.row]
    }
    
    func tappedAddEvent() {
        print("Tapped add event")
        coordinator?.startAddEvent()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let eventCellVM = cells[indexPath.row]
        eventCellVM.didSelect()
    }
    
    
}
