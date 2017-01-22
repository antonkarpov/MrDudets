//
//  BottomPanelViewController.swift
//  MrDudets
//
//  Created by Anton on 18/12/2016.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit
import Crashlytics

class BottomPanelViewController : UIViewController {
    
    @IBAction func settingsButtonAction(_ sender: UIButton) {
        Answers.logCustomEvent(withName: "Settings button pressed", customAttributes: nil)
        
        performSegue(withIdentifier: "SettingsScreenSegue", sender: sender)
    }
    
    @IBAction func rateUsButtonAction(_ sender: UIButton) {
        Answers.logCustomEvent(withName: "RateUs button pressed", customAttributes: nil)
    }
    
}
