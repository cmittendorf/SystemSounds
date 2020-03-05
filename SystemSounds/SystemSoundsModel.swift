//
//  SystemSoundsModel.swift
//  SystemSounds
//
//  Created by Christian Mittendorf on 05.03.20.
//  Copyright © 2020 Christian Mittendorf. All rights reserved.
//

import Foundation
import os

class SystemSoundsModel: ObservableObject {

    @Published var libraries: [SoundLibrary] = []

    init(libraries: [SoundLibrary] = SystemSoundsModel.systemSoundLibraries) {
        self.libraries = libraries
    }
}

extension SystemSoundsModel {
    static var mock: SystemSoundsModel {
        SystemSoundsModel(libraries: [
            SoundLibrary(name: "UISounds",
                         description: "Lorem ipsum dolor sit ament.",
                         sounds: [Sound.mock, Sound.mock]),
            SoundLibrary(name: "UISounds",
                         description: "Lorem ipsum dolor sit ament.",
                         sounds: [Sound.mock, Sound.mock])
        ])
    }
}

extension SystemSoundsModel {
    static var systemSoundLibraries: [SoundLibrary] {
        var libraries: [SoundLibrary] = []

        do {
            libraries = try ["/System/Library/Audio/UISounds",
                 "/Library/Ringtones"]
                .map { path in
                let category = URL(fileURLWithPath: path).lastPathComponent
                let sounds = try FileManager.default
                    .contentsOfDirectory(atPath: path)
                    .compactMap { Sound(path: "\(path)/\($0)") }
                    .sorted()

                return SoundLibrary(name: category,
                                          description: "Sound files stored in the location \"\(path)\".",
                                          sounds: sounds)
            }
        } catch {
            os_log("%s", error.localizedDescription)
        }

        return libraries
    }
}
