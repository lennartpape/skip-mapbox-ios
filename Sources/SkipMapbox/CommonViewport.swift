//
//  CommonViewport.swift
//
//
//  Created by John Bent on 8/28/24.
//

#if SKIP || !os(macOS)

import Foundation
import SwiftUI
#if !SKIP
import MapboxMaps
import CoreLocation
#else
import com.mapbox.maps.`extension`.compose.animation.viewport.__
import com.mapbox.maps.plugin.viewport.data.DefaultViewportTransitionOptions
import com.mapbox.maps.plugin.viewport.data.OverviewViewportStateOptions
import com.mapbox.maps.plugin.viewport.data.FollowPuckViewportStateOptions
import com.mapbox.maps.__
import com.mapbox.geojson.Point
import com.mapbox.geojson.Geometry
import com.mapbox.maps.plugin.viewport.__
#endif

#if SKIP
public typealias CGFloat = Double
public typealias CGPoint = ScreenCoordinate

public class Viewport: Equatable {
    public enum Storage: Equatable {
        case idle
        case styleDefault
        case camera(CameraOptions)
        case overview(OverviewOptions)
        case followPuck(FollowPuckOptions)
    }
    
    /// Options for the overview viewport.
    public struct OverviewOptions: Equatable {
        /// Geometry to overview.
        public var geometry: Geometry
        /// Camera bearing.
        public var bearing: CGFloat

        /// Camera pitch.
        public var pitch: CGFloat

        /// Extra padding that is added for the geometry during bounding box calculation.
        ///
        /// - Note: Geometry padding is different to camera padding ``Viewport/padding-swift.property``.
        public var geometryPadding: SwiftUI.EdgeInsets

        /// The maximum zoom level to allow.
        public var maxZoom: Double?

        /// The center of the given bounds relative to the map's center, measured in points.
        public var offset: CGPoint?
        
        func toOverviewViewportStateOptions(duration: Long?) -> OverviewViewportStateOptions {
            return OverviewViewportStateOptions.Builder()
                .geometry(geometry)
                .geometryPadding(com.mapbox.maps.EdgeInsets(
                    Double(geometryPadding.top),
                    Double(geometryPadding.leading),
                    Double(geometryPadding.bottom),
                    Double(geometryPadding.trailing)
                ))
                .bearing(bearing)
                .pitch(pitch)
                .maxZoom(maxZoom)
                .offset(offset ?? ScreenCoordinate(0.0, 0.0))
                .animationDurationMs(duration ?? DEFAULT_STATE_ANIMATION_DURATION_MS)
                .build()
        }
    }
    
    /// Options for the follow puck viewport.
    public struct FollowPuckOptions: Equatable {
        /// Camera zoom.
        public var zoom: CGFloat

        /// Camera bearing.
        public var bearing: FollowPuckViewportStateBearing

        /// Camera pitch.
        public var pitch: CGFloat
        
        func toFollowPuckViewportStateOptions() -> FollowPuckViewportStateOptions {
            return FollowPuckViewportStateOptions.Builder()
                .zoom(zoom)
                .bearing(bearing.mapboxValue)
                .pitch(pitch)
                .build()
        }
    }
    
    private var storage: Storage
    public let mapViewportState: MapViewportState
    
    public init(storage: Storage) {
        self.storage = storage
        mapViewportState = MapViewportState()
        updateMapViewportState()
    }

    /// Denotes camera padding of the viewport.
    public var padding: SwiftUI.EdgeInsets = SwiftUI.EdgeInsets()
    private var mapboxPadding: com.mapbox.maps.EdgeInsets {
        return com.mapbox.maps.EdgeInsets(
            Double(padding.top),
            Double(padding.leading),
            Double(padding.bottom),
            Double(padding.trailing)
        )
    }
    
    public static var idle: Viewport {
        return Viewport(storage: Storage.idle)
    }
    
    public static var styleDefault: Viewport {
        Viewport(storage: Storage.styleDefault)
    }
    
    public static func camera(center: CLLocationCoordinate2D? = nil,
                              anchor: CGPoint? = nil,
                              zoom: CGFloat? = nil,
                              bearing: CLLocationDirection? = nil,
                              pitch: CGFloat? = nil) -> Viewport {
        var centerPoint: Point? = center?.point
        
        let cameraOptions = CameraOptions.Builder()
            .center(centerPoint)
            .pitch(pitch)
            .zoom(zoom)
            .bearing(bearing)
            .build()
        return Viewport(storage: .camera(cameraOptions))
    }
    
    public static func overview(
        geometry: GeometryConvertible,
        bearing: CGFloat = 0,
        pitch: CGFloat = 0,
        geometryPadding: SwiftUI.EdgeInsets = .init(),
        maxZoom: Double? = nil,
        offset: CGPoint? = nil
    ) -> Viewport {
        let options = OverviewOptions(
            geometry: geometry.geometry,
            bearing: bearing,
            pitch: pitch,
            geometryPadding: geometryPadding,
            maxZoom: maxZoom,
            offset: offset
        )
        return Viewport(storage: .overview(options))
    }
    
    public static func followPuck(
        zoom: CGFloat,
        bearing: FollowPuckViewportStateBearing = .constant(0.0),
        pitch: CGFloat = 0.0
    ) -> Viewport {
        let options = FollowPuckOptions(
            zoom: zoom,
            bearing: bearing,
            pitch: pitch
        )
        return Viewport(storage: .followPuck(options))
    }
    
    public func withViewportAnimation(animation: ViewportAnimation, updatedViewport: Viewport, completion: ((Bool) -> Void)?) {
        self.storage = updatedViewport.storage
        let animationData = ViewportAnimationData(animation: animation, completion: completion)
        updateMapViewportState(animationData: animationData)
    }
    
    public func withImmediateTransition(updatedViewport: Viewport) {
        self.storage = updatedViewport.storage
        updateMapViewportState()
    }
    
    private func updateMapViewportState(animationData: ViewportAnimationData? = nil) {
        switch storage {
        case .idle:
            mapViewportState.idle()
        case .styleDefault:
            guard let cameraOptions = mapViewportState.styleDefaultCameraOptions else { return }
            if let animationData {
                animateToCameraOptions(cameraOptions, animationData: animationData)
            } else {
                mapViewportState.apply { setCameraOptions(cameraOptions) }
            }
        case .camera(let cameraOptions):
            if let animationData {
                animateToCameraOptions(cameraOptions, animationData: animationData)
            } else {
                mapViewportState.apply { setCameraOptions(cameraOptions) }
            }
        case .overview(let overviewOptions):
            if let animationData {
                mapViewportState.transitionToOverviewState(
                    overviewViewportStateOptions: overviewOptions.toOverviewViewportStateOptions(duration: animationData.animation.duration ?? DEFAULT_TRANSITION_MAX_DURATION_MS),
                    defaultTransitionOptions: animationData.animation.defaultViewportTransitionOptions,
                    completionListener: animationData.completion
                )
            } else {
                mapViewportState.transitionToOverviewState(
                    overviewViewportStateOptions: overviewOptions.toOverviewViewportStateOptions(duration: 0)
                )
            }
        case .followPuck(let followPuckOptions):
            if let animationData {
                mapViewportState.transitionToFollowPuckState(
                    followPuckViewportStateOptions: followPuckOptions.toFollowPuckViewportStateOptions(),
                    defaultTransitionOptions: animationData.animation.defaultViewportTransitionOptions,
                    completionListener: animationData.completion
                )
            } else {
                mapViewportState.transitionToFollowPuckState(
                    followPuckViewportStateOptions: followPuckOptions.toFollowPuckViewportStateOptions()
                )
            }
        }
    }
    
    private func animateToCameraOptions(_ cameraOptions: CameraOptions, animationData: ViewportAnimationData) {
        switch animationData.animation.animationType {
        case .default(_), .fly(_):
            mapViewportState.flyTo(
                cameraOptions,
                animationData.animation.mapAnimationOptions,
                completionListener: animationData.completion
            )
        default:
            // all other animation types employ the easeTo method
            mapViewportState.easeTo(
                cameraOptions,
                animationData.animation.mapAnimationOptions,
                completionListener: animationData.completion
            )
        }
    }
}

public enum FollowPuckViewportStateBearing {
    case constant(_ bearing: CLLocationDirection)
    case heading
    case course
    
    var mapboxValue: com.mapbox.maps.plugin.viewport.data.FollowPuckViewportStateBearing? {
        switch self {
        case let .constant(bearing):
            return com.mapbox.maps.plugin.viewport.data.FollowPuckViewportStateBearing.Constant(bearing)
        case .heading, .course:
            return com.mapbox.maps.plugin.viewport.data.FollowPuckViewportStateBearing.SyncWithLocationPuck
        }
    }
}

#endif

#endif
