//
//  MDDurationLabel.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

class MDDurationLabel: UILabel {
    
    var timer: Timer?
    var currentTimePassed = 0
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.isHidden = true
        
    }
    
    func startTimer() {
        
        self.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.updateTimerLabel),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    func stopTimer() {
        
        self.isHidden = true
        timer?.invalidate()
        
        currentTimePassed = 0
        self.text = "00:00"
        
    }
    
    func updateTimerLabel() {
        
        self.currentTimePassed += 1
        self.text = String(format: "00:%02d", currentTimePassed)
        
    }
}
