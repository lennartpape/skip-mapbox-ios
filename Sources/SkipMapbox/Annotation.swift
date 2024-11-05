//
//  Annotation.swift
//
//
//  Created by John Bent on 9/6/24.
//
#if SKIP || !os(iOS)
import Foundation

#if SKIP
import com.mapbox.maps.ScreenCoordinate
import com.mapbox.geojson.Point

/// A structure that defines additional information about map content gesture
public struct MapContentGestureContext {
    /// The location of gesture in Map view bounds.
    public var point: CGPoint

    /// Geographical coordinate of the map gesture.
    public var coordinate: CLLocationCoordinate2D
    
    init(point: Point) {
        // not sure how to get this value on Android
        self.point = CGPoint(0.0, 0.0)
        coordinate = CLLocationCoordinate2D(latitude: point.latitude(), longitude: point.longitude())
    }
}
#endif
#endif
