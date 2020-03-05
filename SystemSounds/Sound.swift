//
//  Sound.swift
//  SystemSounds
//
//  Created by Christian Mittendorf on 05.03.20.
//  Copyright © 2020 Christian Mittendorf. All rights reserved.
//

import Foundation
import AVFoundation

struct Sound {

    let url: URL
    let soundID: SystemSoundID

    init?(path: String) {
        let url = URL(fileURLWithPath: path)
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)

        guard soundID > 0
            else { return nil }

        self.url = url
        self.soundID = soundID
    }

    var name: String {
        url.lastPathComponent
    }

    func play() {
        AudioServicesPlaySystemSound(soundID)
    }
}

extension Sound: Comparable {
    static func < (lhs: Sound, rhs: Sound) -> Bool {
        lhs.soundID < rhs.soundID
    }
}

extension Sound: Identifiable {
    var id: String {
        url.absoluteString
    }
}

extension Sound {
    init(url: URL, soundID: SystemSoundID) {
        self.url = url
        self.soundID = soundID
    }

    static var mock: Sound {
        Sound(url: URL(fileURLWithPath: "file:///SomeSoundFile.caf"), soundID: 42)
    }
}
