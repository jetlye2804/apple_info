//
//  DeviceDisplayOverallView.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 25/02/2023.
//

import SwiftUI

struct DeviceDisplayOverallView: View {
    let deviceDisplay: ProductIOSDetailModel.ProductDisplayModel
    
    func booleanConversion(value: Bool) -> String {
        if(value == true){
            return "Yes"
        } else {
            return "No"
        }
    }
    
    var body: some View {
        List {
            Group{
                HStack {
                    Text("Name")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(deviceDisplay.name)
                            .foregroundColor(.gray)
                        if(deviceDisplay.promotion_display == true){
                            Text("with ProMotion")
                                .foregroundColor(.gray)
                        }
                    }
                }
                HStack {
                    Text("Screen Type")
                    Spacer()
                    Text(deviceDisplay.screen_type)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("LED Backlight")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.led_backlight))
                        .foregroundColor(.gray)
                }
            }
            
            Section {
                let screenSize = deviceDisplay.screen_size_resolution
                HStack{
                    Spacer()
                    ZStack {
                        if(deviceDisplay.name.contains("Liquid") || deviceDisplay.name.contains("Super")){
                            if(deviceDisplay.dynamic_island == true){
                                Image(systemName: "iphone.gen3")
                                    .font(.system(size: 144, design: .rounded))
                            } else {
                                Image(systemName: "iphone.gen2")
                                    .font(.system(size: 144, design: .rounded))
                            }
                        } else {
                            Image(systemName: "iphone.gen1")
                                .font(.system(size: 144, design: .rounded))
                        }
                        Text(String(format:"%.1f", screenSize.diagonal_inch))
                            .font(.system(size: 36, design: .rounded))
                    }
                    
                    Spacer()
                }.listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0))
            }
            
            Section(header: Text("Size and Resolution")) {
                let screenSize = deviceDisplay.screen_size_resolution
                HStack{
                    Text("Screen Size")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(String(format:"%.2f", screenSize.diagonal_inch))-inch (diagonal)")
                            .foregroundColor(.gray)
                        Text("\(String(format:"%.2f", screenSize.vertical_inch))-inch by \(String(format:"%.2f", screenSize.horizontal_inch)) inch")
                            .foregroundColor(.gray)
                    }
                }
                HStack{
                    Text("Resolution")
                    Spacer()
                    Text("\(String(screenSize.vertical_physical))-by-\(String(screenSize.horizontal_physical))")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Logical Width")
                    Spacer()
                    Text("\(String(screenSize.vertical_logical))-by-\(String(screenSize.horizontal_logical))")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Scale Factor")
                    Spacer()
                    Text("@\(screenSize.scale_factor)x")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Pixel Density")
                    Spacer()
                    Text("\(screenSize.pixel_density) ppi")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Aspect Ratio")
                    Spacer()
                    Text(screenSize.aspect_ratio)
                        .foregroundColor(.gray)
                }
            }
            
            Section (header: Text("Brightness and Contrast")) {
                let brightness = deviceDisplay.brightness_contrast
                HStack{
                    Text("Typical Max Brightness")
                    Spacer()
                    Text("\(String(brightness.typical_max)) nits")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("HDR Max Brightness")
                    Spacer()
                    if(brightness.hdr_max != nil) {
                        Text("\(String(brightness.hdr_max!)) nits")
                            .foregroundColor(.gray)
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                }
                HStack{
                    Text("Outdoor Max Brightness")
                    Spacer()
                    if(brightness.outdoor_max != nil) {
                        Text("\(String(brightness.outdoor_max!)) nits")
                            .foregroundColor(.gray)
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                }
                HStack{
                    Text("Contrast Ratio")
                    Spacer()
                    Text("\(String(brightness.contrast_ratio)):1")
                        .foregroundColor(.gray)
                }
            }
            
            Section {
                let hueColors = stride(from: 0, to: 1, by: 0.01).map {
                        Color(hue: $0, saturation: 1, brightness: 1)
                    }
                if(deviceDisplay.p3 == true) {
                    HStack {
                        Spacer()
                        Text("Display P3")
                            .font(.system(size: 54))
                            .fontWeight(.semibold)
                        Spacer()
                    }.listRowBackground(LinearGradient(gradient: Gradient(colors: hueColors), startPoint: .leading, endPoint: .trailing))
                } else {
                    HStack {
                        Spacer()
                        Text("sRGB")
                            .font(.system(size: 54))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                
                
            }
            
            Section (header: Text("Color")) {
                HStack {
                    Text("sRGB")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.srgb))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Display P3")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.p3))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Color Depth")
                    Spacer()
                    Text("\(deviceDisplay.color_bit)-bit")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("True Tone")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.true_tone))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Night Shift")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.night_shift))
                        .foregroundColor(.gray)
                }
            }
            
            Section {

            }
            
            Section (header: Text("Motion")){
                HStack {
                    Text("ProMotion Display")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.promotion_display))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Always-On Display")
                    Spacer()
                    Text(booleanConversion(value: deviceDisplay.always_on_display))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Refresh Rate")
                    Spacer()
                    if(deviceDisplay.promotion_display == true){
                        Text("\(deviceDisplay.refresh_rate_min)Hz to \(deviceDisplay.refresh_rate_max)Hz")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(deviceDisplay.refresh_rate_max)Hz")
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            
        }.navigationTitle("Display")
    }
}
