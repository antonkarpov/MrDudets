//
//  MDDurationLabel.swift
//  MrDudets
//
//  Created by RomanPanichkin on 08/10/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit

class MDDurationLabel: UILabel {
    let GCTimerStoppedNotification = "Timer stopped"
    var timer: NSTimer?
    var currentTimePassed = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hidden = true
    }
    
    func startTimer() {
        self.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        self.hidden = true
        timer?.invalidate()
    }
    
    func updateTimerLabel() {
        if currentTimePassed == 30 {
            NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: GCTimerStoppedNotification, object: nil))
            self.hidden = true
            timer?.invalidate()
            return
        }
        
        self.currentTimePassed += 1
        self.text = String(format: "00:%02d", currentTimePassed)
    }
}
