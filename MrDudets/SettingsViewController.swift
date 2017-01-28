//
//  SettingsViewController.swift
//  MrDudets
//
//  Created by Роман Паничкин on 12/18/16.
//  Copyright © 2016 Anton Karpov. All rights reserved.
//

import UIKit
import MessageUI
import Crashlytics

class SettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let SupportEmail = "roman.panichkin23@gmail.com"
    let MailSubject = "Users feedback"
    
    
    @IBAction func rateUsAction(_ sender: UIButton) {
        //TO DO: implement a rate the app action
        Answers.logCustomEvent(withName: "RateUsInSettings button pressed", customAttributes: nil)
    }
    
    @IBAction func letsDudetsAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func contactSupportAction(_ sender: UIButton) {
        Answers.logCustomEvent(withName: "Contact support button pressed", customAttributes: nil)
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([SupportEmail])
        mailComposerVC.setSubject(MailSubject)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
