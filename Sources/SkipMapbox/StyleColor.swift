//
//  StyleColor.swift
//  
//
//  Created by John Bent on 9/6/24.
//

#if SKIP || !os(iOS)

#if SKIP
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.colorspace.ColorSpace
import androidx.compose.ui.graphics.colorspace.ColorSpaces

public struct StyleColor: Equatable {
    public let javaColor: Color
    
    /// Creates a `StyleColor` from individually-provided color components. Returns nil
    /// if any of the channel values are out of the supported ranges.
    /// - Parameters:
    ///   - red: A value from 0 to 255, as required by the Mapbox Style Spec
    ///   - green: A value from 0 to 255, as required by the Mapbox Style Spec
    ///   - blue: A value from 0 to 255, as required by the Mapbox Style Spec
    public init?(red: Double, green: Double, blue: Double) {
        guard [red, green, blue].allSatisfy((0.0...255.0).contains) else {
            return nil
        }
        
        let denominator = Float(255.0)
        
        javaColor = Color(
            red: red.toFloat() / denominator,
            green: green.toFloat() / denominator,
            blue: blue.toFloat() / denominator,
            alpha: Float(1.0)
        )
    }

    /// Creates a `StyleColor` from individually-provided color components. Returns nil
    /// if any of the channel values are out of the supported ranges.
    /// - Parameters:
    ///   - red: A value from 0 to 255, as required by the Mapbox Style Spec
    ///   - green: A value from 0 to 255, as required by the Mapbox Style Spec
    ///   - blue: A value from 0 to 255, as required by the Mapbox Style Spec
    ///   - alpha: A value from 0 to 1, as required by the Mapbox Style Spec
    public init?(red: Double, green: Double, blue: Double, alpha: Double) {
        guard [red, green, blue].allSatisfy((0.0...255.0).contains),
              (0.0...1.0).contains(alpha) else {
            return nil
        }
        
        let denominator = Float(255.0)
        
        javaColor = Color(
            red: red.toFloat() / denominator,
            green: green.toFloat() / denominator,
            blue: blue.toFloat() / denominator,
            alpha: Float(alpha)
        )
    }
}

#endif
#endif
