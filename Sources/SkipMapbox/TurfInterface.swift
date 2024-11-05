//
//  TurfInterface.swift
//
//
//  Created by John Bent on 9/3/24.
//

#if SKIP || !os(iOS)

#if !SKIP
import CoreLocation
#else
import com.mapbox.geojson.Geometry

public protocol GeometryConvertible {
    public var geometry: Geometry { get }
}



#endif

#endif
