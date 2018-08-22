//
//  ViewController.swift
//  GTA-Calc
//
//  Created by Gatien ANIZAN on 10/05/2018.
//  Copyright © 2018 Gatien ANIZAN. All rights reserved.
//

import UIKit
import  UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var topHintLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var resupplyLabel: UILabel!
    @IBOutlet weak var resupplyLabelWarning: UILabel!
    @IBOutlet weak var upgradeSwitch: UISwitch!
    @IBOutlet var resupplyBtn: UIView!
    
    var unitValue: Int = 0;
    
    override func viewDidLoad() {
        print("App start")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            // Enable or disable features based on authorization.
        }
    }
    
    @IBAction func btnClick(_ sender: Any) {
        
        checkUpgrade()
        
        if input.text == "" {
            clearView()
            input.resignFirstResponder() // Ferme le clavier
        } else if Int(input.text!)! < unitValue {
            clearView()
            errorLabel.text = "Value must be higher than \(unitValue)"
            errorLabel.isHidden = false
        } else if Int(input.text!)! > unitValue * 100 {
            clearView()
            errorLabel.text = "Value must be lower than \(unitValue * 100)"
            errorLabel.isHidden = false
        } else if input.text != "" {
            input.resignFirstResponder() // Ferme le clavier
            let res: Float = ((100 - (Float(input.text!)! / 7000)) * 7) / 60
            let fillbar: Float = Float(input.text!)! / 700000
            let fill: Float = fillbar * 100
            let hours: Int = Int(res)
            let resupply: Float = (res * 60) / 140
            label.text = "Full in \(hours)h\(toMinute(time: res))"
            label.isHidden = false
            label2.text = "Filled at \(Int(fill.rounded()))%"
            label2.isHidden = false
            progress.progress = fillbar
            progress.isHidden = false
            errorLabel.isHidden = true
            resupplyLabel.text = "\(Int(resupply.rounded(.up))) resupply will be necessary"
            resupplyLabel.isHidden = false
            resupplyLabelWarning.isHidden = false
        }
        print(upgradeSwitch.isOn)
    }
    
    @IBAction func resupplyClick(_ sender: Any) {
        // Configure the notification's payload.
        let content = UNMutableNotificationContent()
        content.title = "No more supplies!"
        content.body = "Your bunker ran out of supplies"
        content.sound = UNNotificationSound.default()
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 9000, repeats: false)
        let request = UNNotificationRequest(identifier: "NoSuppliesBunker", content: content, trigger: trigger) // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError)
            }
        }
    }
    
    // Remet la view à son état inital
    func clearView() -> Void {
        label.isHidden = true
        label2.isHidden = true
        errorLabel.isHidden = true
        progress.isHidden = true
        resupplyLabel.isHidden = true
        resupplyLabelWarning.isHidden = true
    }
    
    func toMinute(time: Float) -> Int {
        return Int((time-Float(Int(time)))*60)
    }
    
    func checkUpgrade() -> Void {
        if upgradeSwitch.isOn {
            unitValue = 7000
        } else {
            unitValue = 5000
        }
    }
}
