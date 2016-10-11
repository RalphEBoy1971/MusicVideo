//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Ralph Halbrook on 9/1/16.
//  Copyright © 2016 Ralph Halbrook. All rights reserved.
//

import UIKit
import MessageUI

class SettingsTVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    @IBOutlet weak var feedbackDisplay: UILabel!
    @IBOutlet weak var securityDisplay: UILabel!
    @IBOutlet weak var touchID: UISwitch!
    @IBOutlet weak var bestImageDisplay: UILabel!
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var numMV: UILabel!
    @IBOutlet weak var dragSlider: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTVC.preferredFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        tableView.alwaysBounceVertical = false
        
        title = "Settings"

        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        
        if (UserDefaults.standard.object(forKey: "APICNT") != nil) {
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }

    }
    
    @IBAction func valueChanged(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
        
    }
    @IBAction func touchIDSec(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        
        if touchID.isOn {
            defaults.set(touchID.isOn, forKey: "SecSetting")
        } else {
            defaults.set(false, forKey: "SecSetting")
        }
    }
    
    func preferredFontChange() {
        
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        bestImageDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        numMV.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        dragSlider.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 1 {
            
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                
                // No email account Setup on Phone
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["ralph@halbrooksonline.com"])
        mailComposeVC.setSubject("Music Video App Feedback")
        mailComposeVC.setMessageBody("Hi Ralph, \n\nI would like to share the following feedback...\n", isHTML: false)
        
        return mailComposeVC
    }
    
    func mailAlert() {
        
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup for Phone", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            // do something if you want
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}
