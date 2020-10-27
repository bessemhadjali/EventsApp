//
//  TimeRemainingViewModel.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 19/10/2020.
//

import UIKit

final class TimeRemainingViewModel {
    
//     enum Mode {
//        case detail
//        case cell
//    }
    
    let timeRemainingStrings: [String]
//    private let mode: Mode
//
//    var fontSize: CGFloat {
//        switch mode {
//        case .detail:
//            return 30
//        case .cell:
//            return 25
//        }
//    }
//
//    var alignement: UIStackView.Alignment {
//        switch mode {
//        case .detail:
//            return .center
//        case .cell:
//            return .trailing
//        }
//    }
    
    init(timeRemainingStrings: [String]) {
        self.timeRemainingStrings = timeRemainingStrings
        //self.mode = mode
    }
    
    deinit {
        print("end time vm")
    }
}
