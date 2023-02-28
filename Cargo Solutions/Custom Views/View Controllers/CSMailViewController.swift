//
//  CSMailViewController.swift
//  Cargo Solutions
//
//  Created by Christian Diaz on 2/27/23.
//

import UIKit
import MessageUI

class CSMailViewController: MFMailComposeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func composeMail() {
        setToRecipients(["sulacidi@gmail.com"])
        setMessageBody("<p>You're so awesome!<p>", isHTML: true)
    }
}
