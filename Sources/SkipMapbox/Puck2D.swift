//
//  Puck2D.swift
//
//
//  Created by John Bent on 9/6/24.
//

#if SKIP || !os(macOS)

import Foundation
import SwiftUI
#if SKIP
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.ui.Modifier
import com.mapbox.maps.plugin.locationcomponent.createDefault2DPuck
import com.mapbox.maps.plugin.locationcomponent.location
import com.mapbox.maps.`extension`.compose.MapEffect

public enum PuckBearing {
    public case heading
    public case course
    
    var mapboxValue: com.mapbox.maps.plugin.PuckBearing {
        switch self {
        case .heading:
            return com.mapbox.maps.plugin.PuckBearing.HEADING
        case .course:
            return com.mapbox.maps.plugin.PuckBearing.COURSE
        }
    }
}

public struct Puck2D: View {
    private var bearing: PuckBearing
    
    public init(bearing: PuckBearing) {
        self.bearing = bearing
    }
    
    @Composable override func ComposeContent(context: ComposeContext) {
        MapEffect(Unit) { mapView in
            mapView.location.updateSettings {
                locationPuck = createDefault2DPuck(withBearing = true)
                puckBearingEnabled = true
                puckBearing = bearing.mapboxValue
                enabled = true
            }
        }
    }
}
#endif

#endif
