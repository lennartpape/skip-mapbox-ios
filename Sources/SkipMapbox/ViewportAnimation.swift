//
//  ViewportAnimation.swift
//
//
//  Created by John Bent on 9/3/24.
//
#if SKIP || !os(macOS)

import Foundation
#if !SKIP
import MapboxMaps
#else
import com.mapbox.maps.plugin.animation.MapAnimationOptions
import android.animation.TimeInterpolator
import android.view.animation.LinearInterpolator
import android.view.animation.AccelerateInterpolator
import android.view.animation.DecelerateInterpolator
import android.view.animation.AccelerateDecelerateInterpolator
import androidx.interpolator.view.animation.FastOutSlowInInterpolator
import com.mapbox.maps.plugin.viewport.data.DefaultViewportTransitionOptions
import com.mapbox.maps.plugin.viewport.__
import com.mapbox.maps.plugin.animation.CameraAnimatorsFactory
#endif

#if SKIP
public struct ViewportAnimation {
    enum AnimationType {
        case `default`(maxDuration: TimeInterval?)
        case fly(duration: TimeInterval?)
        case easeIn(duration: TimeInterval)
        case easeOut(duration: TimeInterval)
        case easeInOut(duration: TimeInterval)
        case linear(duration: TimeInterval)
    }
    let animationType: AnimationType
    
    /// A default viewport animation.
    ///
    /// The default animation tries to provide best-looking animation for every viewport transition.
    ///
    /// - Note: It's recommended to use the default animation with ``Viewport/followPuck(zoom:bearing:pitch:)``
    /// viewport, because it supports moving animation target (user location puck).
    public static var `default`: ViewportAnimation {
        .init(animationType: .default(maxDuration: nil))
    }
    
    /// A default animation with the specified maximum duration.
    ///
    /// The default animation tries to provide best-looking animation for every viewport transition.
    ///
    /// - Note: It's recommended to use the default animation with ``Viewport/followPuck(zoom:bearing:pitch:)``
    /// viewport, because it supports moving animation target (user location puck).
    ///
    /// - Parameters:
    ///   - maxDuration: The maximum duration of the animation, measured in seconds.
    /// - Returns: A default viewport animation.
    public static func `default`(maxDuration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .default(maxDuration: maxDuration))
    }
    
    /// A fly animation.
    ///
    /// The fly animation usually follows the zoom-out, flight, zoom-in pattern in animation.
    /// The duration of the animation will be calculated automatically.
    public static var fly: ViewportAnimation {
        .init(animationType: .fly(duration: nil))
    }
    
    /// A fly animation with a specified duration.
    ///
    /// The fly animation usually follows the zoom-out, flight, zoom-in pattern in animation.
    ///
    /// - Parameters:
    ///   - duration: Duration of the animation, measured in seconds.
    /// - Returns: A fly animation.
    public static func fly(duration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .fly(duration: duration))
    }
    
    /// An animation that starts quickly and then slows towards the end.
    ///
    /// - Parameters:
    ///   - duration: Duration of the animation, measured in seconds.
    /// - Returns: An ease-out animation.
    public static func easeOut(duration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .easeOut(duration: duration))
    }

    /// An animation that starts slowly and then speeds up towards the end.
    ///
    /// - Parameters:
    ///   - duration: Duration of the animation, measured in seconds.
    /// - Returns: An ease-in animation.
    public static func easeIn(duration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .easeIn(duration: duration))
    }

    /// An animation that combines behavior of ease-in and ease-out animations
    ///
    /// - Parameters:
    ///   - duration: Duration of the animation, measured in seconds.
    /// - Returns: An ease-in-out animation.
    public static func easeInOut(duration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .easeInOut(duration: duration))
    }

    /// An animation that moves at a constant speed.
    ///
    /// - Parameters:
    ///   - duration: Duration of the animation, measured in seconds.
    /// - Returns: A linear animation.
    public static func linear(duration: TimeInterval) -> ViewportAnimation {
        .init(animationType: .linear(duration: duration))
    }
}

extension ViewportAnimation {
    // Returns the associated duration in milliseconds if one is available
    var duration: Long? {
        switch animationType {
        case let .default(duration):
            return duration?.milliseconds
        case let .fly(duration):
            return duration?.milliseconds
        case let .easeIn(duration):
            return duration.milliseconds
        case let .easeOut(duration):
            return duration.milliseconds
        case let .easeInOut(duration):
            return duration.milliseconds
        case let .linear(duration):
            return duration.milliseconds
        }
    }
    
    /// Maps the viewport animation and duration to a `MapAnimationOptions` configuration.
    /// Note that these mappings are a best effort to match iOS animations with Android animations
    /// and that there will be some discrepancies.
    var mapAnimationOptions: MapAnimationOptions {
        var interpolator: TimeInterpolator?
        var animationDuration: Long?
        switch animationType {
        case let .default(duration):
            // note: this duration diverges from the Android default, which is 1 second
            // in order to match iOS this is set to 3.5 seconds
            animationDuration = duration?.milliseconds ?? DEFAULT_TRANSITION_MAX_DURATION_MS
            interpolator = FastOutSlowInInterpolator()
        case let .fly(duration):
            // note: this duration diverges from the Android default, which is 1 second
            // in order to match iOS this is set to 3.5 seconds
            animationDuration = duration?.milliseconds ?? DEFAULT_TRANSITION_MAX_DURATION_MS
            interpolator = FastOutSlowInInterpolator()
        case .easeIn(let duration):
            animationDuration = duration.milliseconds
            interpolator = AccelerateInterpolator()
        case .easeOut(let duration):
            animationDuration = duration.milliseconds
            interpolator = DecelerateInterpolator()
        case .easeInOut(let duration):
            animationDuration = duration.milliseconds
            interpolator = AccelerateDecelerateInterpolator()
        case .linear(let duration):
            animationDuration = duration.milliseconds
            interpolator = LinearInterpolator()
        }
        var builder = MapAnimationOptions.Builder()
        if let interpolator {
            builder.interpolator(interpolator)
        }
        if let animationDuration {
            builder.duration(animationDuration)
        }
        return builder.build()
    }
    
    /// Convenience for converting a viewport animation to its DefaultViewportTransitionOptions
    /// with the corresponding maxDuration value.
    var defaultViewportTransitionOptions: DefaultViewportTransitionOptions {
        var builder = DefaultViewportTransitionOptions.Builder()
        builder.maxDurationMs(duration ?? DEFAULT_TRANSITION_MAX_DURATION_MS)
        return builder.build()
    }
}

struct ViewportAnimationData {
    let animation: ViewportAnimation
    let completion: ((Bool) -> Void)?
}
#endif

#endif
