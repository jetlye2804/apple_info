extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

import Foundation

struct ProductListModel: Codable {
    let type: String
    let name: String
    let device_list: DeviceList
    
    struct DeviceList: Codable {
        let supported: [String]
        let unsupported: [String]
    }
}


