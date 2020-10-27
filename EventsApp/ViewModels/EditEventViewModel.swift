//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 20/10/2020.
//

import UIKit
import CoreData

final class EditEventViewModel {
    enum Cell {
        case titleSubTitle(TitleSubTitleCellViewModel)
    }
    
    var coordinator: EditEventCoordinator?
    
    let title = "Edit"
    
    private var nameCellVM: TitleSubTitleCellViewModel?
    private var dateCellVM: TitleSubTitleCellViewModel?
    private var imageCellVM: TitleSubTitleCellViewModel?
    
    private(set) var cells: [Cell] = []
    
    lazy var dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    let event: Event
    let eventService: EventServiceProtocol
    
    init(event: Event, eventService: EventServiceProtocol = EventService()) {
        self.event = event
        self.eventService = eventService
    }
    
    func viewDidLoad(onUpdate: @escaping () -> Void) {
        nameCellVM = TitleSubTitleCellViewModel(title: "Name", subtitle: "", placeHolder: "Add a name...", type: .text, onUpdate: {})
        dateCellVM =  TitleSubTitleCellViewModel(title: "Date", subtitle: "", placeHolder: "select a date...", type: .date, onUpdate: {
            onUpdate()
            
        })
        imageCellVM = TitleSubTitleCellViewModel(title: "Background", subtitle: "", placeHolder: "", type: .image, onUpdate: {
            onUpdate()
            
        })
        
        guard let nameCellVM = nameCellVM, let dateCellVM = dateCellVM, let imageCellVM = imageCellVM else {return}
        
        cells = [
            .titleSubTitle(
                nameCellVM
            ),
            .titleSubTitle(
                
                dateCellVM
                
            ),
            .titleSubTitle(
                imageCellVM
            )
        ]
        guard let eventName = event.name,  let date = event.date, let imageData = event.image, let image = UIImage(data: imageData)  else {
            onUpdate()
            return
        }
        
        nameCellVM.update(subtitle: eventName)
        dateCellVM.update(date: date)
        imageCellVM.update(image: image)
        
        onUpdate()
    }
    
    func viewDidDisapear() {
        coordinator?.didFinish()
    }
    
    
    func numberOfRow() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func updateCell(indewPath: IndexPath, subtitle: String) {
        
        switch cells[indewPath.row] {
        case .titleSubTitle(let titleSubTitleCellVM):
            titleSubTitleCellVM.update(subtitle: subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
        switch cells[indexPath.row] {
        case .titleSubTitle(let titleSubTitleCellVM):
            if titleSubTitleCellVM.type == .image {
                coordinator?.ShowImagePicker(completition: { image in
                    titleSubTitleCellVM.update(image: image)
                    
                })
            }
            
        }
    }
    
    func tappedDone() {
        print("tapped done")
        // extract info from cell vm and save i core data
        guard let name = nameCellVM?.subtitle, let dateString = dateCellVM?.subtitle, let image = imageCellVM?.image, let date = dateFormatter.date(from: dateString)  else {
            return
        }
        eventService.perform(eventAction: .update(event), eventDataInput: EventService.EventDataInput(name: name, date: date, image: image))
        // edit event with core data
        coordinator?.didiFinishEditEvent()
    }
    
    
    
    
}
