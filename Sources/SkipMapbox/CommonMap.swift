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
import MapboxMaps
#else
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import com.mapbox.geojson.Point
import com.mapbox.maps.MapboxExperimental
#endif

#if SKIP
public struct Map: View {
    let viewport: Binding<Viewport>
    
    public init(viewport: Binding<Viewport>) {
        self.viewport = viewport
    }
    
    @Composable override func ComposeContent(context: ComposeContext) {
        com.mapbox.maps.extension.compose.MapboxMap(
            context.modifier,
            mapViewportState = viewport.wrappedValue.mapViewportState
        )
    }
}
#endif
#endif
