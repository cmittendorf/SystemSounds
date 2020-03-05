//
//  ContentView.swift
//  SystemSounds
//
//  Created by Christian Mittendorf on 05.03.20.
//  Copyright © 2020 Christian Mittendorf. All rights reserved.
//

import SwiftUI
import AVFoundation
import os

struct ContentView: View {

    @ObservedObject var model = SystemSoundsModel()

    var body: some View {
        NavigationView {
            SoundsList(model: model)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SoundsList: View {

    var model: SystemSoundsModel

    var body: some View {
        List {
            ForEach(model.libraries) { soundLibrary in
                Section(header: Text(soundLibrary.name),
                        footer: Text(soundLibrary.description)) {
                    ForEach(soundLibrary.sounds) { sound in
                        SoundRow(sound: sound)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("SystemSounds")
    }
}

struct SoundRow: View {

    let sound: Sound

    var body: some View {
        HStack {
            Text("\(sound.name) (\(sound.formattedSoundId))")
            Spacer()
            Button(action: sound.play) {
                Image(systemName: "play.circle")
                    .contentShape(Rectangle())
            }
        }
    }
}

extension Sound {
    var formattedSoundId: String {
        NumberFormatter.localizedString(from: NSNumber(value: soundID), number: .none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: SystemSoundsModel.mock)
    }
}
