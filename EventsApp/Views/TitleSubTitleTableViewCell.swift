//
//  TitleSubTitleTableViewCell.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 13/10/2020.
//

import UIKit

class TitleSubTitleTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    private var datePicker: UIDatePicker!
    private var toolBar: UIToolbar!
    
   private(set) var titleSubTitleCellViewModel: TitleSubTitleCellViewModel!
    
    // le selector ne marche pas comme ça il faut utiliser Lazy var !!!!!!!
    //private var doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
    
    lazy var doneButtonItem : UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDone))
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // frame ne marche pas !!!!!!!!
        datePicker = UIDatePicker(frame: CGRect(x: 100, y: 100, width: self.bounds.size.width, height: 500))
        datePicker.datePickerMode = .date
        //datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        datePicker.preferredDatePickerStyle = .wheels
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 50))
        toolBar.setItems([doneButtonItem], animated: false)
        
        //
        self.photoImageView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func update (with viewModel: TitleSubTitleCellViewModel) {
        self.titleSubTitleCellViewModel = viewModel
        self.labelTitle.text = viewModel.title
        self.textField.placeholder = viewModel.placeHolder
        self.textField.text = viewModel.subtitle
        self.textField.inputView = viewModel.type == .text ? nil : datePicker
        self.textField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        self.textField.isHidden = viewModel.type == .image
        self.photoImageView.isHidden = viewModel.type != .image
        self.photoImageView.image = viewModel.image
        
        
    }
    
    @objc func datePickerDone() {
        //textField.text = "\(datePicker.date)"
        let date = datePicker.date
        self.titleSubTitleCellViewModel.update(date: date)
        
    }
    
    //    @objc func dateChanged() {
    //        textField.text = "\(datePicker.date)"
    //       }
    
}
