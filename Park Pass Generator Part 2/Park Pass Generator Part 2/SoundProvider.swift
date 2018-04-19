//
//  SoundProvider.swift
//  Park Pass Generator Part 2
//
//  Created by Jaakko Kenttä on 19/04/2018.
//  Copyright © 2018 Jaakko Kenttä. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import AudioToolbox

enum GameSounds {
    case accessDenied
    case accessGranted
}
class AudioProvider {
    
    static var accessDenied: SystemSoundID = 0
    static var accessGranted: SystemSoundID = 1

    
    static func playSound(named: GameSounds) {
        
        var soundFileName: String
        var soundID: SystemSoundID
        
        switch named {
        case .accessDenied:
            soundFileName = "AccessDenied"
            soundID = accessDenied
        case .accessGranted:
            soundFileName = "AccessGranted"
            soundID = accessGranted
        }
        
        let pathToSoundFile = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
        
        AudioServicesPlaySystemSound(soundID)
    }
    
}
