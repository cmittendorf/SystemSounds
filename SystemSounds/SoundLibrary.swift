//
//  SoundLibrary.swift
//  SystemSounds
//
//  Created by Christian Mittendorf on 05.03.20.
//  Copyright © 2020 Christian Mittendorf. All rights reserved.
//

import Foundation

struct SoundLibrary {
    let name: String
    let description: String
    let sounds: [Sound]
}

extension SoundLibrary: Identifiable {
    var id: String {
        name
    }
}
