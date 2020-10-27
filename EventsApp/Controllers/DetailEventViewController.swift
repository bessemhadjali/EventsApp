//
//  DetailEventViewController.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 18/10/2020.
//

import UIKit

class DetailEventViewController: UIViewController {
    
    var eventDetailViewModel: EventDetailViewModel!

    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet  var timeRemainingStackView: TimeRemainingStackView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"), style: .plain, target: eventDetailViewModel, action: #selector(eventDetailViewModel.editButtonTapped))

        
        eventDetailViewModel.onUpadate = { [weak self] in
                
                self?.backgroundImageView.image = self?.eventDetailViewModel.backgroundImage
                self?.eventNameLabel.text = self?.eventDetailViewModel.eventName
                self?.dateLabel.text = self?.eventDetailViewModel.date
                if let timeRemainingVM = self?.eventDetailViewModel.timeRemainingVM {
                    self?.timeRemainingStackView.update(with: timeRemainingVM, mode: .detail)
                }
           
        }
        
        eventDetailViewModel.getEvent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        eventDetailViewModel.didDisappear()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
