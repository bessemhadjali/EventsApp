//
//  imagePickerCoordinator.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 16/10/2020.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    var onFinishPicking: ((UIImage) -> Void)?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        self.navigationController.present(imagePickerController, animated: true, completion: nil)
    }
    
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            
            onFinishPicking?(image)
           
        }
        
        parentCoordinator?.childDidFinish(self)
    }
}
