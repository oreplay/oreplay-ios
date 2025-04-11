//
//  NetworkMonitorTests.swift
//  OReplayTest
//
//  Created by Amador Navarro Lucas on 6/4/25.
//  Copyright © 2025 com.ruralnerd. All rights reserved.
//

import Network

protocol NWPathMonitorContract {
    @preconcurrency var pathUpdateHandler: (@Sendable (_ newPath: NWPath.Status) -> Void)? { get set }
    func start(queue: DispatchQueue)
}

extension NWPathMonitor: NWPathMonitorContract {
    var pathUpdateHandler: (@Sendable (NWPath.Status) -> Void)?
    
    
}
