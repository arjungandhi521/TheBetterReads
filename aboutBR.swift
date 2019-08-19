//
//  addABook.swift
//  My Reads
//
//  Created by Digital Media on 1/4/18.
//  Copyright © 2018 Arjun Gandhi. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MessageUI

// About the Better Reads page.
class AboutBR: UIViewController, MFMailComposeViewControllerDelegate {
    
    // Contact the Better Reads button
    @IBAction func contactUs(sender: UIButton) {
        // if mail app in unavalible then print error message
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["BetterReadsTeam@gmail.com"]) // Better Read's email auto fills
        composeVC.setSubject("") // set subject to blank
        composeVC.setMessageBody("", isHTML: false) // set body of email to blank
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // Go back to home screen.
    @IBAction func goHome(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

