//
//  ViewController.swift
//  GTA-Calc
//
//  Created by Gatien ANIZAN on 10/05/2018.
//  Copyright © 2018 Gatien ANIZAN. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        print("App start")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnClick(_ sender: Any) {
        if input.text == "" {
            clearView()
        } else if Int(input.text!)! < 7000 {
            clearView()
            errorLabel.text = "Value must be higher than 7 000"
            errorLabel.isHidden = false
        } else if Int(input.text!)! > 700000 {
            clearView()
            errorLabel.text = "Value must be lower than 700 000"
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
    }
    
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
}
