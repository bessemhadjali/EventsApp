//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 12/10/2020.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    
    var parentCoordinator: EventListCoordinator?
    //var completition: ((UIImage) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instanctiate()
        let addEventVM = AddEventViewModel(eventService: EventService())
        addEventViewController.addEventViewModel = addEventVM
        addEventVM.coordinator = self
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)
        guard let modalNavigationController = modalNavigationController else  {return}
        self.navigationController.present(modalNavigationController, animated: true)
    }
    
    
    func ShowImagePicker(completition: @escaping (UIImage) -> Void) {
        print("image view selected")
        guard let modalNavigationController = modalNavigationController else  {return}
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            self.modalNavigationController?.dismiss(animated: true, completion: nil)
            completition(image)
            
        }
        imagePickerCoordinator.start()
        //self.completition = completition
    }
    
    func didFinish() {
        
        parentCoordinator?.childDidFinish(self)
        
    }
    
    func didiFinishSaveEvent() {
        self.navigationController.dismiss(animated: true, completion: nil)
        parentCoordinator?.onUpdateEvent()
    }
    
    func didCancelAddEvent() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    
    
//    func didFinishPickingImage(_ image: UIImage) {
//
//        self.completition?(image)
//        self.modalNavigationController?.dismiss(animated: true, completion: nil)
//    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
                
    }
    
   
    
    
}
