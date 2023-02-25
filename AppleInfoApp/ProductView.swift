import SwiftUI

class ReadData: ObservableObject  {
    @Published var productList: ProductListModel?
    @Published var iosDeviceList = [ProductIOSDetailModel]()
    
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "iphone_list", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        guard let url2 = Bundle.main.url(forResource: "ios_device", withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: url)
        else {
            print("Failed to get data")
            return
        }
        guard let data2 = try? Data(contentsOf: url2)
        else {
            print("Failed to get data")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let productList = try decoder.decode(ProductListModel.self, from: data)
            let iosDeviceList = try decoder.decode([ProductIOSDetailModel].self, from: data2)
            self.productList = productList
            self.iosDeviceList = iosDeviceList
        } catch let error {
            print(error)
        }
    }
     
}

struct ProductView: View {
    @ObservedObject var data = ReadData()

    var product: Product
    var body: some View {
        if(product.path == "iphone"){
            List {
                Section(header: Text("Supported Devices")) {
                    ForEach(data.productList!.device_list.supported) { device in
                        NavigationLink {
                            ForEach(data.iosDeviceList, id: \.self) { iosDevice in
                                if(iosDevice.name == device){
                                    ProductDetailView(deviceName: device, iosDevice: iosDevice)
                                }
                            }
                            
                        } label: {
                            Text(device)
                        }
                    }
                }
                
                Section(header: Text("Unupported Devices")) {
                    ForEach(data.productList!.device_list.unsupported) { device in
                        NavigationLink {
                            ForEach(data.iosDeviceList, id: \.self) { iosDevice in
                                if(iosDevice.name == device){
                                    ProductDetailView(deviceName: device, iosDevice: iosDevice)
                                }
                            }
                            
                        } label: {
                            Text(device)
                        }
                    }
                }
            }
            .navigationBarTitle(product.name, displayMode: .automatic)
        } else {
            Image(systemName: "nosign")
                .font(.system(size: 88, design: .rounded))
                .fontWeight(Font.Weight.bold)
                .padding([.bottom], 8)
            Text("Not available in this moment")
                .font(.system(size: 28))
                .fontWeight(Font.Weight.bold)
                .multilineTextAlignment(.center)
                .navigationBarTitle(product.name, displayMode: .automatic)
        }
        
        
    }
}
