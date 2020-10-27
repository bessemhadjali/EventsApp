//
//  TitleSubTitleCellViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 13/10/2020.
//

import UIKit

final class TitleSubTitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    
    private(set) var subtitle: String
    
    let placeHolder: String
    
    private(set) var image: UIImage?
    
    let type: CellType
    
    lazy var dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    private(set) var onUpdate:() -> Void = {}
    
    init(title: String, subtitle: String, placeHolder: String, type: CellType, onUpdate: @escaping (() -> Void ) ) {
        self.title = title
        self.subtitle = subtitle
        self.placeHolder = placeHolder
        self.type = type
        self.onUpdate = onUpdate
    }
    
    func update (subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update (date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        self.onUpdate()
    }
    
    func update(image: UIImage) {
        self.image = image
        self.onUpdate()
    }
}
