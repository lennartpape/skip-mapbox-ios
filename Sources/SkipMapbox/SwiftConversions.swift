//
//  SwiftConversions.swift
//
//
//  Created by John Bent on 9/6/24.
//

import Foundation

#if SKIP
public extension TimeInterval {
    var milliseconds: Long { return (self * 1000.0).toLong() }
}

public struct UIEdgeInsets {
    public let top: Double
    public let right: Double
    public let bottom: Double
    public let left: Double
}
#endif
