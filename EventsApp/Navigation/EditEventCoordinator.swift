//
//  EditEventCoordinator.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 20/10/2020.
//

import UIKit

final class EditEventCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let event: Event
    
    var parentCoordinator: DetailEventCoordinator?
    //var completition: ((UIImage) -> Void)?
    
    //var onEditEvent: () -> Void = {}
    
    init(navigationController: UINavigationController, event: Event) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        let editEventViewController: EditEventViewController = .instanctiate()
        let editEventViewModel = EditEventViewModel(event: event)
        editEventViewModel.coordinator = self
        editEventViewController.editEventViewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
    }
    
   
    
    func ShowImagePicker(completition: @escaping (UIImage) -> Void) {
        print("image view selected")
        
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completition(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        imagePickerCoordinator.start()
       // self.completition = completition
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didiFinishEditEvent() {
        self.navigationController.popViewController(animated: true)
        //onEditEvent()
        parentCoordinator?.onEditEvent()
    }
    
    
    
//    func didFinishPickingImage(_ image: UIImage) {
//
//        self.completition?(image)
//        self.navigationController.dismiss(animated: true, completion: nil)
//    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
                
    }
    
    
    
}
