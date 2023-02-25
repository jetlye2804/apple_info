//
//  DeviceChipOverallView.swift
//  SwiftUIDarkMode
//
//  Created by Jet Lye on 22/02/2023.
//

import SwiftUI

struct DeviceChipOverallView: View {
    let deviceChip: ProductIOSDetailModel.ProductChipModel
    
    func transistorConversion(number: Int) -> String {
        if(number >= 1000000000000){
            return "\(Decimal(number) / 1000000000000) trillion"
        } else if(number >= 1000000000){
            return "\(Decimal(number) / 1000000000) billion"
        } else if(number >= 1000000){
            return "\(Decimal(number) / 1000000) million"
        } else {
            return "\(number)"
        }
    }
    
    func opsConversion(number: Int) -> String {
        if(number >= 1000000000000){
            return "\(Decimal(number) / 1000000000000) TOPS"
        } else if(number >= 1000000000){
            return "\(Decimal(number) / 1000000000) BOPS"
        } else {
            return "\(number)"
        }
    }
    
    func frequencyConversion(number: Int) -> String {
        if(number >= 1000){
            return "\(Decimal(number) / 1000) GHz"
        } else {
            return "\(number) MHz"
        }
    }
    
    func cacheAmountConversion(number: Int) -> String {
        if(number >= 1000){
            return "\(Decimal(number) / 1000) MB"
        } else {
            return "\(number) KB"
        }
    }
    
    func memoryAmountConversion(number: Int) -> String {
        if(number >= 1000){
            return "\(Decimal(number) / 1000) GB"
        } else {
            return "\(number) MB"
        }
    }
    
    func bandwidthConversion(number: Int) -> String {
        if(number >= 1000){
            return "\(Decimal(number) / 1000) GB/s"
        } else {
            return "\(Decimal(number)) MB/s"
        }
    }
    
    func booleanConversion(value: Bool) -> String {
        if(value == true){
            return "Yes"
        } else {
            return "No"
        }
    }
    
    func memoryTypeShorten(memoryType: String) -> [String] {
        return memoryType.components(separatedBy: "-")
    }

    var body: some View {
        List {
            
            Group {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(deviceChip.name)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Codename")
                    Spacer()
                    Text("\(deviceChip.code_name) (\(deviceChip.part_no))")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Process Node")
                    Spacer()
                    Text("\(deviceChip.process_node_nm) nm (\(deviceChip.process_node))")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Process Foundry")
                    Spacer()
                    Text(deviceChip.manufacturer)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Transistors count")
                    Spacer()
                    Text(transistorConversion(number: deviceChip.transistors_count))
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("CPU"), footer: deviceChip.cpu.hybrid_core == true ? Text("""
            P-core: Performance core
            E-core: Efficiency core
            """) : Text("")){
                let cpu = deviceChip.cpu
                HStack {
                    Text("Instruction Set")
                    Spacer()
                    Text("\(cpu.isa)v\(cpu.isa_version)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Hybrid Core")
                    Spacer()
                    Text(booleanConversion(value: cpu.hybrid_core))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Total Core No.")
                    Spacer()
                    if(cpu.hybrid_core == true && cpu.efficiency_core != nil){
                        Text("\(cpu.performance_core.core_no + cpu.efficiency_core!.core_no)")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(cpu.performance_core.core_no)")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text(cpu.hybrid_core == true ? "Performance core" : "Core")
                    Spacer()
                    Text("\(cpu.performance_core.core_no)-core \(cpu.performance_core.core_name)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(cpu.hybrid_core == true ? "P-core speed" : "Speed")
                    Spacer()
                    Text(frequencyConversion(number: cpu.performance_core.clock_speed))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text(cpu.hybrid_core == true ? "P-core AMX" : "AMX")
                    Spacer()
                    Text(booleanConversion(value: cpu.performance_core.core_amx))
                        .foregroundColor(.gray)
                }
                if(cpu.hybrid_core == true && cpu.efficiency_core != nil){
                    let eCore = cpu.efficiency_core!
                    HStack {
                        Text("Efficiency core")
                        Spacer()
                        Text("\(eCore.core_no)-core \(eCore.core_name)")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("E-core speed")
                        Spacer()
                        Text(frequencyConversion(number: eCore.clock_speed))
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("E-core AMX")
                        Spacer()
                        Text(booleanConversion(value: eCore.core_amx))
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Section(header: Text("Cache"), footer: Text("""
            L1 cache can be categorized as two types:
            \u{2022} L1 Instruction Cache (L1i), which is located at the first place
            \u{2022} L1 Data Cache (L1d), which is located at the last place
            
            Since A10X Fusion chip, the L3 cache has been replaced by the  system-level cache (SLC), which is shared by the whole system-on-chip (SoC).
            """)){
                let cpu = deviceChip.cpu
                HStack {
                    Text("L1 Cache")
                    Spacer()
                    if(cpu.hybrid_core == true && cpu.efficiency_core != nil){
                        VStack (alignment: .trailing) {
                            Text("\(cacheAmountConversion(number: cpu.performance_core.core_l1_i_cache)) + \(cacheAmountConversion(number: cpu.performance_core.core_l1_d_cache)) (P)")
                                .foregroundColor(.gray)
                            Text("\(cacheAmountConversion(number: cpu.efficiency_core!.core_l1_i_cache)) + \(cacheAmountConversion(number: cpu.efficiency_core!.core_l1_d_cache)) (E)")
                                .foregroundColor(.gray)
                        }
                        
                    } else {
                        Text("\(cacheAmountConversion(number: cpu.performance_core.core_l1_i_cache)) + \(cacheAmountConversion(number: cpu.performance_core.core_l1_d_cache))")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("L2 Cache")
                    Spacer()
                    if(cpu.hybrid_core == true && cpu.efficiency_core != nil){
                        VStack (alignment: .trailing) {
                            Text("\(cacheAmountConversion(number: cpu.performance_core.core_l2_cache)) (P)")
                                .foregroundColor(.gray)
                            Text("\(cacheAmountConversion(number: cpu.efficiency_core!.core_l2_cache)) (E)")
                                .foregroundColor(.gray)
                        }
                        
                    } else {
                        Text("\(cpu.performance_core.core_l2_cache)")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("L3 Cache")
                    Spacer()
                    if(cpu.l3_cache != nil){
                        Text(String(cpu.l3_cache!))
                            .foregroundColor(.gray)
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("System-level Cache")
                    Spacer()
                    if(cpu.slc_cache != nil){
                        Text(String(cpu.slc_cache!) + " MB")
                            .foregroundColor(.gray)
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            
            Section(header: Text("GPU")){
                let gpu = deviceChip.gpu
                HStack {
                    Text("Name")
                    Spacer()
                    if(gpu.is_apple_designed == true){
                        Text("\(gpu.name) Apple-designed")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(gpu.name)")
                            .foregroundColor(.gray)
                    }
                    
                }
                HStack {
                    Text("Vendor")
                    Spacer()
                    Text("\(gpu.vendor)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Total Core No.")
                    Spacer()
                    Text("\(gpu.core_no)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Total Core No.")
                    Spacer()
                    Text("\(gpu.core_no)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Execution Units")
                    Spacer()
                    Text("\(gpu.eu_no)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Arithmetic Logic Units")
                    Spacer()
                    Text("\(gpu.alu_no)")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("GPU Speed")
                    Spacer()
                    Text("\(String(gpu.frequency)) MHz")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("FLOPS")
                    Spacer()
                    Text("\(String(format:"%.3f", gpu.flops)) \(gpu.flops_unit)OPS")
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Metal Support")
                    Spacer()
                    if(gpu.metal_2 == true){
                        if(gpu.metal_3 == true){
                            Text("Metal 3")
                                .foregroundColor(.gray)
                        } else {
                            Text("2")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("N/A")
                            .foregroundColor(.gray)
                    }
                }
                HStack {
                    Text("Apple GPU Family")
                    Spacer()
                    Text("Family \(gpu.gpu_family)")
                        .foregroundColor(.gray)
                }
            }
            
            if(deviceChip.has_neural_engine == true && deviceChip.neural_engine != nil) {
                let neuralEngine = deviceChip.neural_engine!
                Section(header: Text("Neural Engine"), footer: Text("""
                Since A12 Bionic chip, all third-party apps can access the Neural Engine
                """)){
                    HStack {
                        Text("Core No.")
                        Spacer()
                        Text("\(neuralEngine.core_no)")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Max OPS")
                        Spacer()
                        Text(opsConversion(number: neuralEngine.ops))
                            .foregroundColor(.gray)
                    }
                }
            }
            
            HStack{
                Spacer()
                VStack {
                    ZStack {
                        Image(systemName: "memorychip")
                            .font(.system(size: 96, design: .rounded))
                        Text(memoryTypeShorten(memoryType: deviceChip.memory.type)[0])
                            .fontWeight(.semibold)
                    }
                    Text(memoryAmountConversion(number: deviceChip.memory.capacity))
                        .font(.system(size: 18, design: .default))
                        .fontWeight(.semibold)
                        .textCase(.uppercase)
                }
                Spacer()
            }.listRowBackground(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0))
            
            Section(header: Text("Memory")){
                let memory = deviceChip.memory
                HStack{
                    Text("Capacity")
                    Spacer()
                    Text(memoryAmountConversion(number: memory.capacity))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Type")
                    Spacer()
                    Text(memory.type)
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Frequency")
                    Spacer()
                    Text("\(memory.frequency) MHz")
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Width")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(memory.channel_no * memory.bit_per_channel)-bit")
                            .foregroundColor(.gray)
                        Text("\(memory.bit_per_channel)-bit/channel")
                            .foregroundColor(.gray)
                        Text("\(memory.channel_no) \(memory.channel_no > 1 ? "channels" : "channel")")
                            .foregroundColor(.gray)
                    }
                }
                HStack{
                    Text("Bandwidth")
                    Spacer()
                    Text(bandwidthConversion(number: memory.bandwidth))
                        .foregroundColor(.gray)
                }
                HStack{
                    Text("Memory Swapping Support")
                    Spacer()
                    Text(booleanConversion(value: memory.memory_swap))
                        .foregroundColor(.gray)
                }
            }
            
        }.navigationTitle("Chip")
    }
}

