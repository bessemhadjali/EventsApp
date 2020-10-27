//
//  EventTableViewCell.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 17/10/2020.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateRemainigLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with eventCellvm: EventCellViewModel) {
       
        //
        self.eventNameLabel.text = eventCellvm.eventName
        //
        self.dateLabel.text = eventCellvm.date
        
        //
        var dateRemainigString = ""
        eventCellvm.timeRemainingStrings.forEach {
            dateRemainigString +=  "\($0)\n"
        }
        self.dateRemainigLabel.text = dateRemainigString
        
        //
        eventCellvm.loadImage { image in
            self.backgroundImageView.image = image 
        }
//        self.yearLabel.text = eventCellvm.years
//        self.monthLabel.text = eventCellvm.months
//        self.weekLabel.text = eventCellvm.weeks
//        self.dayLabel.text = eventCellvm.days
       
    }

}
