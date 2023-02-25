//
//  ProductDetailModel.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 20/02/2023.
//

import Foundation

struct ProductIOSDetailModel: Hashable, Codable {
    let type: String
    let name: String
    let slogan: String
    let image: String
    let hardware_string: String
    let model_number: [String]
    let support_status: String
    let date: ProductDateModel
    let resistance: ProductResistanceModel
    let operating_system: ProductOperatingSystemModel
    let dimension: ProductDimensionModel
    let material: ProductMaterialModel
    let color: [ProductColorModel]
    let chip: ProductChipModel
    let storage: ProductStorageModel
    let display: ProductDisplayModel
    
    struct ProductDateModel: Hashable, Codable {
        let announced_date: String
        let released_date: String
        let discontinued_date: String
        let unsupported_date: String
    }

    struct ProductResistanceModel: Hashable, Codable {
        let ip_rating: String
        let max_depth: Int
        let is_resistant_common_liquid: Bool
    }

    struct ProductOperatingSystemModel: Hashable, Codable {
        let initial_os: String
        let initial_build: String
        let latest_os: String
        let latest_build: String
    }

    struct ProductDimensionModel: Hashable, Codable {
        let height: Double
        let width: Double
        let depth: Double
        let weight: [Double]
    }

    struct ProductMaterialModel: Hashable, Codable {
        let front: String
        let side: String
        let back: String
        let ceramic_shield: Bool
    }

    struct ProductColorModel: Hashable, Codable {
        let name: String
        let code: String
    }
    
    struct ProductChipModel: Hashable, Codable {
        let name: String
        let code_name: String
        let part_no: String
        let process_node: String
        let process_node_nm: Int
        let manufacturer: String
        let transistors_count: Int
        let cpu: ChipCPUModel
        let gpu: ChipGPUModel
        let has_neural_engine: Bool
        let neural_engine: ChipNEModel?
        let memory: MemoryModel
        
        struct ChipCPUModel: Hashable, Codable {
            let isa: String
            let isa_version: String
            let bit_width: Int
            let hybrid_core: Bool
            let performance_core: CPUPerformanceModel
            let efficiency_core: CPUEfficiencyModel?
            let l3_cache: Int?
            let slc_cache: Int?
            
            struct CPUPerformanceModel: Hashable, Codable {
                let core_name: String
                let core_no: Int
                let clock_speed: Int
                let core_l1_i_cache: Int
                let core_l1_d_cache: Int
                let core_l2_cache: Int
                let core_amx: Bool
            }

            struct CPUEfficiencyModel: Hashable, Codable {
                let core_name: String
                let core_no: Int
                let clock_speed: Int
                let core_l1_i_cache: Int
                let core_l1_d_cache: Int
                let core_l2_cache: Int
                let core_amx: Bool
            }
        }
        
        struct ChipGPUModel: Hashable, Codable {
            let name: String
            let is_apple_designed: Bool
            let vendor: String
            let core_no: Int
            let eu_no: Int
            let alu_no: Int
            let frequency: Int
            let flops: Double
            let flops_unit: String
            let metal_2: Bool
            let metal_3: Bool
            let gpu_family: Int
        }
        
        struct ChipNEModel: Hashable, Codable {
            let core_no: Int
            let ops: Int
        }
        
        struct MemoryModel: Hashable, Codable {
            let type: String
            let frequency: Int
            let channel_no: Int
            let bit_per_channel: Int
            let bandwidth: Int
            let capacity: Int
            let memory_swap: Bool
            let memory_swap_remarks: String
        }
    }
    
    struct ProductStorageModel: Hashable, Codable {
        let capacity: [Int]
        let type: String
    }
    
    struct ProductDisplayModel: Hashable, Codable {
        let led_backlight: Bool
        let screen_type: String
        let name: String
        let screen_size_resolution: DisplayResolutionModel
        let brightness_contrast: DisplayBrightnessContrastModel
        let oleophobic_coating: Bool
        let srgb: Bool
        let p3: Bool
        let color_bit: Int
        let true_tone: Bool
        let night_shift: Bool
        let promotion_display: Bool
        let always_on_display: Bool
        let refresh_rate_max: Int
        let refresh_rate_min: Int
        let hdr_display: Bool
        let hdr_content: Bool
        let dolby_vision: Bool
        let dolby_vision_hdr: Bool
        let dynamic_island: Bool
        let apple_pencil_hover: Bool
        
        struct DisplayResolutionModel: Hashable, Codable {
            let diagonal_inch: Double
            let horizontal_inch: Double
            let vertical_inch: Double
            let horizontal_physical: Int
            let vertical_physical: Int
            let horizontal_logical: Int
            let vertical_logical: Int
            let scale_factor: Int
            let pixel_density: Int
            let aspect_ratio: String
        }
        
        struct DisplayBrightnessContrastModel: Hashable, Codable {
            let typical_max: Int
            let hdr_max: Int?
            let outdoor_max: Int?
            let contrast_ratio: Int
        }
    }
}








