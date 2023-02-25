//
//  DeviceModelView.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 21/02/2023.
//

import SwiftUI

struct DeviceModelListView: View {
    let deviceModelList: [String]
    
    var body: some View {
        List {
            ForEach(deviceModelList) { deviceModel in
                Text(deviceModel)
            }
        }.navigationTitle("Model Number")
    }
}

