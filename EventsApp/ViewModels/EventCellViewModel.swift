//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 17/10/2020.
//

import UIKit
import CoreData

final class EventCellViewModel {
    
    //    var days:  String {
    //
    //        "6 days"
    //    }
    //
    //    var months: String {
    //
    //        "1 month"
    //    }
    //
    //    var weeks: String {
    //
    //        "3 weeks"
    //    }
    //
    //    var years: String {
    //
    //        "4 years"
    //    }
    
    static let imageCache =  NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    var eventName: String? {
        event.name
    }
    
    func loadImage (completion: @escaping (UIImage?) -> Void) {
        
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData)  else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            
        }
    }
    
//    var backgroundImage: UIImage {
//        guard let imageData = event.image else {
//            return UIImage()
//        }
//        return UIImage(data: imageData) ?? UIImage()
//    }
    
    var date: String? {
        guard let eventDate = event.date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else {
            return []
        }
        let timeRemainingString = Date().timeRemaining(until: eventDate)
        return timeRemainingString?.components(separatedBy: ", ") ?? []
    }
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
    
    
    func didSelect() {
        
        let id = event.objectID
        onSelect(id)
        
    }
}
