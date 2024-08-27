//
//  Map.swift
//
//
//  Created by John Bent on 8/27/24.
//

#if SKIP || !os(macOS)

import Foundation
import SwiftUI
#if !SKIP
@_spi(Experimental) import MapboxMaps
#else
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import com.mapbox.geojson.Point
import com.mapbox.maps.MapboxExperimental
#endif

public struct MapView: View {
    #if !SKIP
    @State var viewport: Viewport = .styleDefault
    #endif
    
    public init() {
        
    }
    
    #if !SKIP
    public var body: some View {
        MapboxMaps.Map(viewport: $viewport) {
            Puck2D(bearing: .heading)
                .showsAccuracyRing(true)
        }
        .mapStyle(.outdoors)
    }
    #else
    @Composable override func ComposeContent(context: ComposeContext) {
        com.mapbox.maps.extension.compose.MapboxMap(
            context.modifier,
            mapViewportState = com.mapbox.maps.extension.compose.animation.viewport.MapViewportState().apply {
                setCameraOptions {
                    zoom(2.0)
                    center(Point.fromLngLat(-98.0, 39.5))
                    pitch(0.0)
                    bearing(0.0)
                }
            }
        )
    }
    #endif
}

#endif
