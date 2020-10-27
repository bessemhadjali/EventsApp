//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by Bessem Hadj Ali on 19/10/2020.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    
    private let TimeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    enum Mode {
        case detail
        case cell
    }
    
    private var mode: Mode?
    
    //     override init(frame: CGRect) {
    //           super.init(frame: frame)
    //           setup()
    //       }
    
    //     convenience init(mode: Mode) {
    //        self.init(frame: .zero)
    //        self.mode = mode
    //        //setup()
    //
    //    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    var fontSize: CGFloat {
        guard let mode = self.mode else {
            return 30
            
        }
        switch mode {
        case .detail:
            return 40
        case .cell:
            return 30
        }
    }
    
    var alignement: UIStackView.Alignment {
        guard let mode = self.mode else {
            return .center
            
        }
        switch mode {
        case .detail:
            return .center
        case .cell:
            return .trailing
        }
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        TimeRemainingLabels.forEach {
            addArrangedSubview($0)
        }
        
        axis = .vertical
    }
    
    func update(with timeRemainingViewModel: TimeRemainingViewModel, mode: Mode) {
        self.mode = mode
        alignment = alignement
        TimeRemainingLabels.forEach() {
            $0.text = ""
            $0.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
            $0.textColor = .white
        }
        
        timeRemainingViewModel.timeRemainingStrings.enumerated().forEach() {
            TimeRemainingLabels[$0.offset].text = $0.element
        }
        
    }
    
    deinit {
        print("end time v")
    }
}
