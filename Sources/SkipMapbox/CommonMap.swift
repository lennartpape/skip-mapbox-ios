//
//  Map.swift
//
//
//  Created by John Bent on 8/27/24.
//

#if SKIP || !os(iOS)

import Foundation
import SwiftUI
#if SKIP
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import androidx.compose.runtime.Composable
import androidx.compose.runtime.currentComposer
import com.mapbox.geojson.Point
import com.mapbox.maps.MapboxExperimental
import com.mapbox.maps.`extension`.compose.MapboxMapScope
import com.mapbox.maps.`extension`.compose.MapboxMapComposable
import com.mapbox.maps.`extension`.compose.style.MapStyle
#endif

#if SKIP
public struct Map: View {
    let viewport: Binding<Viewport>
    let content: ComposeBuilder
    @State var mapStyle: MapStyle = .standard
    
    public init(viewport: Binding<Viewport>, @ViewBuilder content: () -> any View = { EmptyView() }) {
        self.viewport = viewport
        self.content = ComposeBuilder.from(content)
    }
    
    @Composable override func ComposeContent(context: ComposeContext) {
        com.mapbox.maps.extension.compose.MapboxMap(
            context.modifier,
            mapViewportState: viewport.wrappedValue.mapViewportState,
            style: { MapStyle(style: mapStyle.androidString) },
            content: { content.Compose(context: context) }
        )
    }
            
    public func mapStyle(_ mapStyle: MapStyle) -> Self {
        self.mapStyle = mapStyle
        return self
    }
}
#endif
#endif
