//
//  CoreLocationInterface.swift
//
//
//  Created by John Bent on 9/1/24.
//
#if SKIP || !os(iOS)

#if !SKIP
import CoreLocation
#else
import com.mapbox.geojson.Point

public typealias CLLocationDegrees = Double
public typealias CLLocationDirection = Double

public struct CLLocationCoordinate2D {
    public let latitude: CLLocationDegrees
    public let longitude: CLLocationDegrees
    
    public var point: Point {
        Point.fromLngLat(longitude, latitude)
    }
}

#endif

#endif
