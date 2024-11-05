//
//  MapStyle.swift
//
//
//  Created by John Bent on 9/6/24.
//

#if SKIP || !os(iOS)
import Foundation
#if SKIP

public struct MapStyle: Equatable {
    public enum Data: Equatable {
        case uri(StyleURI)
        case json(String)
    }
    var data: Data
    
    var androidString: String {
        switch data {
        case .json(let jsonString):
            return jsonString
        case .uri(let uri):
            return uri.rawValue
        }
    }
    
    public init(json: String) {
        data = .json(json)
    }
    
    public init(uri: StyleURI) {
        data = .uri(uri)
    }
    
    /// [Mapbox Standard](https://www.mapbox.com/blog/standard-core-style) is a general-purpose style with 3D visualization.
    public static var standard: MapStyle { MapStyle(uri: .standard) }

    /// [Mapbox Streets](https://www.mapbox.com/maps/streets) is a general-purpose style with detailed road and transit networks.
    public static var streets: MapStyle { MapStyle(uri: .streets) }

    /// [Mapbox Outdoors](https://www.mapbox.com/maps/outdoors) is a general-purpose style tailored to outdoor activities.
    public static var outdoors: MapStyle { MapStyle(uri: .outdoors) }

    /// [Mapbox Light](https://www.mapbox.com/maps/light) is a subtle, light-colored backdrop for data visualizations.
    public static var light: MapStyle { MapStyle(uri: .light) }

    /// [Mapbox Dark](https://www.mapbox.com/maps/dark) is a subtle, dark-colored backdrop for data visualizations.
    public static var dark: MapStyle { MapStyle(uri: .dark) }

    /// The Mapbox Satellite style is a base-map of high-resolution satellite and aerial imagery.
    public static var satellite: MapStyle { MapStyle(uri: .satellite) }

    /// The [Mapbox Satellite Streets](https://www.mapbox.com/maps/satellite) style combines
    /// the high-resolution satellite and aerial imagery of Mapbox Satellite with unobtrusive labels
    /// and translucent roads from Mapbox Streets.
    public static var satelliteStreets: MapStyle { MapStyle(uri: .satelliteStreets) }

    /// Empty map style. Allows to load map without any predefined sources or layers.
    /// Allows to construct the whole style in runtime by composition of  `StyleImport`.
    public static var empty: MapStyle { MapStyle(json: "{ \"layers\": [], \"sources\": {} }") }
}

/// Enum representing the latest version of the Mapbox styles (as of publication). In addition,
/// you can provide a custom URL or earlier version of a Mapbox style by using `init?(url: URL)`.
public struct StyleURI: Hashable, RawRepresentable {
    public typealias RawValue = String

    public let rawValue: String

    /// Create a custom StyleURI from a String. The String may be a full HTTP or HTTPS URI, a Mapbox style URI
    /// (mapbox://styles/{user}/{style}), or a path to a local file relative to the application’s
    /// resource path.
    /// Returns nil if the String is invalid.
    /// - Parameter rawValue: String representation of the URI for the style
    public init?(rawValue: String) {
        guard let url = URL(string: rawValue), url.scheme != nil else {
            return nil
        }

        guard url.isFileURL || url.host != nil else {
            return nil
        }

        self.rawValue = rawValue
    }

    /// Create a custom StyleURI from a URL. The URL may be a full HTTP or HTTPS URI, a Mapbox style URI
    /// (mapbox://styles/{user}/{style}), or a path to a local file relative to the application’s
    /// resource path.
    /// Returns nil if the URL is invalid.
    /// - Parameter url: URL for the style
    public init?(url: URL) {
        self.init(rawValue: url.absoluteString)
    }

    /// Mapbox Streets is a general-purpose style with detailed road and transit networks.
    public static let streets = StyleURI(rawValue: "mapbox://styles/mapbox/streets-v12")!

    /// Mapbox Outdoors is a general-purpose style tailored to outdoor activities.
    public static let outdoors = StyleURI(rawValue: "mapbox://styles/mapbox/outdoors-v12")!

    /// Mapbox Light is a subtle, light-colored backdrop for data visualizations.
    public static let light = StyleURI(rawValue: "mapbox://styles/mapbox/light-v11")!

    /// Mapbox Dark is a subtle, dark-colored backdrop for data visualizations.
    public static let dark = StyleURI(rawValue: "mapbox://styles/mapbox/dark-v11")!

    /// The Mapbox Satellite style is a base-map of high-resolution satellite and aerial imagery.
    public static let satellite = StyleURI(rawValue: "mapbox://styles/mapbox/satellite-v9")!

    /// The Mapbox Satellite Streets style combines the high-resolution satellite and aerial imagery
    /// of Mapbox Satellite with unobtrusive labels and translucent roads from Mapbox Streets.
    public static let satelliteStreets = StyleURI(rawValue: "mapbox://styles/mapbox/satellite-streets-v12")!

    /// Mapbox Standard is a general-purpose style with 3D visualization.
    public static let standard = StyleURI(rawValue: "mapbox://styles/mapbox-map-design/standard-rc")!

    /// Mapbox Standard Satellite
    public static let standardSatellite = StyleURI(rawValue: "mapbox://styles/mapbox/standard-satellite")!
}
#endif
#endif
