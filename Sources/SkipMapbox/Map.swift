//
//  Map.swift
//
//
//  Created by John Bent on 8/27/24.
//

#if !os(macOS)

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

public struct Map: View {
    @State var viewport: Viewport = .styleDefault
    
    public init() {
        
    }
    
    public var body: some View {
        #if !SKIP
        MapboxMaps.Map(viewport: $viewport) {
            Puck2D(bearing: .heading)
                .showsAccuracyRing(true)
        }
        .mapStyle(.outdoors)
        #else
        ComposeView { context in
            com.mapbox.maps.extension.compose.MapboxMap(
                context.modifier,
                mapViewportState = MapViewportState().apply {
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
}

#endif
