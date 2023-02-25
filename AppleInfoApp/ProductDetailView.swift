//
//  ProductDetailView.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 19/02/2023.
//

import Foundation
import SwiftUI

struct ProductDetailView: View {
    private let adaptiveColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    let deviceName: String
    var iosDevice: ProductIOSDetailModel
    
    @State var currentColorName: String
    @State var currentColorCode: String
    
    init(deviceName: String, iosDevice: ProductIOSDetailModel){
        self.deviceName = deviceName
        self.iosDevice = iosDevice
        
        if(iosDevice.color.count > 0){
            self.currentColorName = iosDevice.color[0].name
            self.currentColorCode = iosDevice.color[0].code
        } else {
            self.currentColorName = "No color"
            self.currentColorCode = "#0000FF"
        }
    }
    
    func test(color: ProductIOSDetailModel.ProductColorModel) -> some View {
        Group {
            Circle()
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color(hex: color.code)!))
                .onTapGesture {
                    self.currentColorName = color.name
                    self.currentColorCode = color.code
            }
        }
    }
    
    func cpuNameShorten(cpuName: String) -> [String] {
        return cpuName.components(separatedBy: " ")
    }
    
    func weightConverter(weight: Double) -> String {
        if(weight >= 1000){
            return "\(weight / 1000) kg"
        } else {
            return "\(weight) g"
        }
        
    }
    
    var body: some View {
        List{
            VStack {
                Text("")
                Divider()
                    .frame(height: 5)
                    .overlay(.gray)
                    .padding([.top], 0)
                    .padding([.bottom], 10)
                VStack {
                    Text(iosDevice.name)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Text(iosDevice.slogan)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                }
                LazyVGrid(columns: adaptiveColumns, spacing: 10){
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .overlay(
                                VStack {
                                    Text("Announced Date")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, design: .rounded))
                                    Text(iosDevice.date.announced_date)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, design: .rounded))
                                }
                            )
                    }
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .overlay(
                                VStack {
                                    Text("Released Date")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, design: .rounded))
                                    Text(iosDevice.date.released_date)
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, design: .rounded))
                                }
                            )
                    }
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundColor(iosDevice.date.discontinued_date != "" ? .yellow : .green)
                            .cornerRadius(20)
                            .overlay(
                                VStack {
                                    if(iosDevice.date.discontinued_date != ""){
                                        Text("Discontinued Date")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                        Text(iosDevice.date.discontinued_date)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                    } else {
                                        Text("In Production")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                    }
                                }
                            )
                    }
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundColor(iosDevice.date.unsupported_date != "" ? .gray : .green)
                            .cornerRadius(20)
                            .overlay(
                                VStack {
                                    if(iosDevice.date.unsupported_date != ""){
                                        Text("Unsupported Date")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                        Text(iosDevice.date.unsupported_date)
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                    } else {
                                        Text("Supported")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, design: .rounded))
                                    }
                                }
                            )
                    }
                    
                }
                
            }
            .listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0))
            
            Section(header: Text("General Information")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(iosDevice.name)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Hardware String")
                    Spacer()
                    Text(iosDevice.hardware_string)
                        .foregroundColor(.gray)
                }
                NavigationLink {
                    DeviceModelListView(deviceModelList: iosDevice.model_number)
                } label: {
                    HStack {
                        Text("Model Number")
                        Spacer()
                        Text("View more")
                            .foregroundColor(.gray)
                    }
                    
                }
                
                HStack {
                    Text("Initial OS")
                    Spacer()
                    Text("\(iosDevice.operating_system.initial_os) (Build \(iosDevice.operating_system.initial_build))")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Latest OS")
                    Spacer()
                    Text("\(iosDevice.operating_system.latest_os) (Build \(iosDevice.operating_system.latest_build))")
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Dimension")) {
                let dimension = iosDevice.dimension
                HStack {
                    Text("Height")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(format:"%.1f", dimension.height)) mm")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Width")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(format:"%.1f", dimension.width)) mm")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Depth")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(format:"%.1f", dimension.depth)) mm")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Weight")
                    Spacer()
                    VStack(alignment: .trailing) {
                        ForEach(dimension.weight, id: \.self) { weight in
                            Text("\(weightConverter(weight: weight))")
                                .foregroundColor(.gray)
                        }
                        
                    }
                }
            }
            
            Section(header: Text("Dimension")) {
                let material = iosDevice.material
                HStack {
                    Text("Front")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(material.front)\(material.ceramic_shield == true ? " with Ceramic Shield" : "")")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Back")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(material.back)
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Side")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(material.side)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Section(header: Text("Color"), footer: Text("Tap on any color dot to show the color name.")) {
                VStack {
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(alignment: .center, spacing: 20) {
                                ForEach(iosDevice.color, id: \.self) { color in
                                    Circle()
                                        .stroke(
                                            self.currentColorName == color.name ? .blue : Color(hex: 0xFFFFFF, alpha: 0), lineWidth: 4
                                        )
                                        .frame(width: 48, height: 48)
                                        .background(Circle().fill(Color(hex: color.code)!))
                                        .onTapGesture {
                                            self.currentColorName = color.name
                                        }
                                }
                                .padding(8)
                                .multilineTextAlignment(.center)
                            }
                            .frame(minWidth: geometry.size.width)
                            
                        }
                    }
                    Spacer()
                    Text(self.currentColorName)
                        .padding([.top], 48)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }
                .padding([.top, .bottom], 4)
                .multilineTextAlignment(.center)
            }
            
            HStack{
                Spacer()
                ZStack {
                    Image(systemName: "cpu")
                        .font(.system(size: 88, design: .rounded))
                    Image(systemName: "apple.logo")
                        .font(.system(size: 24, design: .rounded))
                }
                VStack {
                    Text(cpuNameShorten(cpuName: iosDevice.chip.name)[0])
                        .font(.system(size: 48, design: .default))
                        .fontWeight(.semibold)
                    if(cpuNameShorten(cpuName: iosDevice.chip.name)[1] != ""){
                        Text(cpuNameShorten(cpuName: iosDevice.chip.name)[1])
                            .font(.system(size: 18, design: .default))
                            .fontWeight(.semibold)
                            .textCase(.uppercase)
                    }
                    
                }
                
                Spacer()
            }.listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0))
            
            Section(header: Text("Chip")) {
                NavigationLink {
                    DeviceChipOverallView(deviceChip: iosDevice.chip)
                } label: {
                    HStack {
                        Text("Chip Name")
                        Spacer()
                        Text(iosDevice.chip.name)
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            
            Section(header: Text("Storage")) {

            }
            
            HStack{
                Spacer()
                ZStack {
                    if(iosDevice.display.name.contains("Liquid") || iosDevice.display.name.contains("Super")){
                        if(iosDevice.display.dynamic_island == true){
                            Image(systemName: "iphone.gen3")
                                .font(.system(size: 88, design: .rounded))
                        } else {
                            Image(systemName: "iphone.gen2")
                                .font(.system(size: 88, design: .rounded))
                        }
                    } else {
                        Image(systemName: "iphone.gen1")
                            .font(.system(size: 88, design: .rounded))
                    }
                }
                VStack (alignment: .leading) {
                    if(iosDevice.display.name.contains("Retina")){
                        if(iosDevice.display.name.contains("XDR")){
                            Text("XDR")
                                .font(.system(size: 48, design: .default))
                                .fontWeight(.semibold)
                        } else if(iosDevice.display.name.contains("Liquid")) {
                            Text("Liquid")
                                .font(.system(size: 48, design: .default))
                                .fontWeight(.semibold)
                        } else {
                            Text("Retina")
                                .font(.system(size: 48, design: .default))
                                .fontWeight(.semibold)
                        }
                    }
                    
                    if(iosDevice.display.promotion_display == true){
                        Text("ProMotion")
                            .font(.system(size: 16, design: .default))
                            .fontWeight(.semibold)
                    }
                    
                    if(iosDevice.display.always_on_display == true){
                        Text("Always-On")
                            .font(.system(size: 16, design: .default))
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
            }.listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0))
            
            Section(header: Text("Display")) {
                NavigationLink {
                    DeviceDisplayOverallView(deviceDisplay: iosDevice.display)
                } label: {
                    HStack {
                        Text("Display")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(iosDevice.display.name)
                                .foregroundColor(.gray)
                            if(iosDevice.display.promotion_display == true){
                                Text("with ProMotion")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationBarTitle("Details", displayMode: .automatic)
    }
}
struct ViewWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
