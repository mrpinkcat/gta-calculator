//
//  File.swift
//  GTA-Calc
//
//  Created by Gatien ANIZAN on 13/05/2018.
//  Copyright © 2018 Gatien ANIZAN. All rights reserved.
//

import Foundation

class Translations {
    var topHint: String = "err tr"
    var inputPlaceholder = "err tr"
    var btn: String = "err tr"
    
    init(language: String) {
        print(language)
        if language == "fr" {
            self.topHint = "Veuillez entrer la valeur de votre bunker ci-dessous"
            self.inputPlaceholder = "Valeur"
            self.btn = "Calculer"
        }
        if language == "en" {
            self.topHint = "Please enter the value of your bunker below"
            self.inputPlaceholder = "Bunker value"
            self.btn = "Calculate"
        }
    }
    
}
