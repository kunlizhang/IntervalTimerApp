//
//  SettingsView.swift
//  Interval Timer | HIIT
//
//  Created by Kunli Zhang on 20/02/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var settings: Settings
    
    var body: some View {
        Form {
            Section {
                Picker("Beep countdown", selection: $settings.beepLength) {
                    Text("3 seconds").tag(Settings.BeepLength.threeSec)
                    Text("5 seconds").tag(Settings.BeepLength.fiveSec)
                }
            }
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(Settings()))
    }
}
