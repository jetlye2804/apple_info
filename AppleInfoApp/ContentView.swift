//
//  ContentView.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 05/02/2023.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct ContentView: View {
    // @State private var isShowingDetailView = false
    @State private var data: [Product] = [
        Product(name: "iPhone", icon: "iphone", path: "iphone"),
        Product(name: "iPad", icon: "ipad", path: "ipad"),
        Product(name: "MacBook", icon: "laptopcomputer", path: "macbook"),
        Product(name: "Mac Desktop", icon: "desktopcomputer", path: "macdesktop"),
        Product(name: "Apple Watch", icon: "applewatch", path: "applewatch"),
        Product(name: "AirPods", icon: "airpodspro", path: "airpods"),
        Product(name: "Apple TV", icon: "appletv", path: "appletv"),
        Product(name: "Apple Silicon", icon: "cpu", path:"applesilicon"),
    ]
    
    // Flexible, custom amount of columns that fill the remaining space
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Adaptive, make sure it's the size of your smallest element.
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 160))
    ]
    
    // Fixed, creates columns with fixed dimensions
    private let fixedColumns = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                HStack{
                    Spacer()
                    Group{
                        Image(systemName: "circle")
                            .fontWeight(.ultraLight)
                            .font(.system(size: 48, design: .rounded))
                            .foregroundColor(.gray)
                            .padding([.trailing], 0)
                        Group {
                            Image(systemName: "circle")
                                .fontWeight(.ultraLight)
                                .font(.system(size: 48, design: .rounded))
                                .foregroundColor(.gray)
                                .padding([.leading, .trailing], -28)
                            Image(systemName: "circle")
                                .fontWeight(.ultraLight)
                                .font(.system(size: 48, design: .rounded))
                                .foregroundColor(.blue)
                                .padding([.leading, .trailing], -12)
                            
                        }
//                        Image(systemName: "circle.fill")
//                            .font(.system(size: 48, design: .rounded))
//                            .padding([.leading], -40)
                    }
                    Spacer()
                }
                
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(data) { product in
                        ZStack {
                            NavigationLink {
                                ProductView(product: product)
                            } label: {
                                Rectangle()
                                    .frame(width: 160, height: 160)
                                    .foregroundColor(.gray)
                                    .cornerRadius(30)
                                    .overlay(
                                        VStack {
                                            Image(systemName: product.icon)
                                                .foregroundColor(.black)
                                                .font(.system(size: 56, design: .rounded))
                                                .padding([.bottom], 8)
                                            Text(product.name)
                                                .foregroundColor(.black)
                                                .font(.system(size: 18, design: .rounded))
                                        }
                                    )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Apple Info")
            .padding()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
