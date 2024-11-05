//
//  CircleAnnotation.swift
//  
//
//  Created by John Bent on 9/6/24.
//
#if SKIP || !os(iOS)

import Foundation
import SwiftUI
#if SKIP
import com.mapbox.geojson.Point
import com.mapbox.geojson.Geometry

public struct CircleAnnotation: View, Equatable {
    /// Identifier for this annotation
    internal(set) public var id: String
    
    /// The point backing this annotation
    var point: Point
    
    @Composable override func ComposeContent(context: ComposeContext) {
        let blur = remember { circleBlur }
        let color = remember { circleColor }
        let opacity = remember { circleOpacity }
        let radius = remember { circleRadius }
        let strokeColor = remember { circleStrokeColor }
        let strokeOpacity = remember { circleOpacity }
        let strokeWidth = remember { circleStrokeWidth }
        com.mapbox.maps.extension.compose.annotation.generated.CircleAnnotation(
            point = point,
            onClick = { [weak self] annotation in self?.tapHandler?(MapContentGestureContext(point: annotation.point)) ?? false }
        ) {
            circleBlur = self.circleBlur
            circleColor = color?.javaColor
            circleOpacity = self.circleOpacity
            circleRadius = radius
            circleStrokeColor = strokeColor?.javaColor
            circleStrokeOpacity = self.circleStrokeOpacity
            circleStrokeWidth = strokeWidth
        }
    }
    
    /// Toggles the annotation's selection state.
    /// If the annotation is deselected, it becomes selected.
    /// If the annotation is selected, it becomes deselected.
    public var isSelected: Bool = false

    /// Property to determine whether annotation can be manually moved around map
    public var isDraggable: Bool = false
    
    /// Handles tap gesture on this annotation.
    ///
    /// Should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    public var tapHandler: ((MapContentGestureContext) -> Bool)?

    /// Handles long press gesture on this annotation.
    ///
    /// Should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    public var longPressHandler: ((MapContentGestureContext) -> Bool)?

    /// The handler is invoked when the user begins to drag the annotation.
    ///
    /// The annotation should have `isDraggable` set to `true` to make id draggable.
    ///
    /// - Note: In SwiftUI, draggable annotations are not supported.
    ///
    /// The handler receives the `annotation` and the `context` parameters of the gesture:
    /// - Use the `annotation` inout property to update properties of the annotation.
    /// - The `context` contains position of the gesture.
    /// Return `true` to allow dragging to begin, or `false` to prevent it and propagate the gesture to the map's other annotations or layers.
    public var dragBeginHandler: ((inout CircleAnnotation, MapContentGestureContext) -> Bool)?

    /// The handler is invoked when annotation is being dragged.
    ///
    /// The handler receives the `annotation` and the `context` parameters of the gesture:
    /// - Use the `annotation` inout property to update properties of the annotation.
    /// - The `context` contains position of the gesture.
    public var dragChangeHandler: ((inout CircleAnnotation, MapContentGestureContext) -> Void)?

    /// The handler receives the `annotation` and the `context` parameters of the gesture:
    /// - Use the `annotation` inout property to update properties of the annotation.
    /// - The `context` contains position of the gesture.
    public var dragEndHandler: ((inout CircleAnnotation, MapContentGestureContext) -> Void)?
    
    /// Create a circle annotation with a center coordinate and an optional identifier
    /// - Parameters:
    ///   - id: Optional identifier for this annotation
    ///   - centerCoordinate: Coordinate where this circle annotation should be centered
    ///   - isDraggable: Determines whether annotation can be manually moved around map
    ///   - isSelected: Passes the annotation's selection state
    public init(id: String = UUID().uuidString, centerCoordinate: CLLocationCoordinate2D, isSelected: Bool = false, isDraggable: Bool = false) {
        self.id = id
        self.point = centerCoordinate.point
        self.isSelected = isSelected
        self.isDraggable = isDraggable
    }
    
    // MARK: - Style Properties -

    /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
    /// Currently has no effect on Android
    public var circleSortKey: Double?

    /// Amount to blur the circle. 1 blurs the circle such that only the centerpoint is full opacity.
    /// Default value: 0.
    public var circleBlur: Double?

    /// The fill color of the circle.
    /// Default value: "#000000".
    public var circleColor: StyleColor?

    /// The opacity at which the circle will be drawn.
    /// Default value: 1. Value range: [0, 1]
    public var circleOpacity: Double?

    /// Circle radius.
    /// Default value: 5. Minimum value: 0.
    public var circleRadius: Double?

    /// The stroke color of the circle.
    /// Default value: "#000000".
    public var circleStrokeColor: StyleColor?

    /// The opacity of the circle's stroke.
    /// Default value: 1. Value range: [0, 1]
    public var circleStrokeOpacity: Double?

    /// The width of the circle's stroke. Strokes are placed outside of the `circle-radius`.
    /// Default value: 0. Minimum value: 0.
    public var circleStrokeWidth: Double?
}

extension CircleAnnotation {

    /// Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key.
    public func circleSortKey(_ newValue: Double) -> Self {
        circleSortKey = newValue
        return self
    }

    /// Amount to blur the circle. 1 blurs the circle such that only the centerpoint is full opacity.
    /// Default value: 0.
    public func circleBlur(_ newValue: Double) -> Self {
        circleBlur = newValue
        return self
    }

    /// The fill color of the circle.
    /// Default value: "#000000".
    public func circleColor(_ newValue: StyleColor) -> Self {
        circleColor = newValue
        return self
    }

    /// The opacity at which the circle will be drawn.
    /// Default value: 1. Value range: [0, 1]
    public func circleOpacity(_ newValue: Double) -> Self {
        circleOpacity = newValue
        return self
    }

    /// Circle radius.
    /// Default value: 5. Minimum value: 0.
    public func circleRadius(_ newValue: Double) -> Self {
        circleRadius = newValue
        return self
    }

    /// The stroke color of the circle.
    /// Default value: "#000000".
    public func circleStrokeColor(_ newValue: StyleColor) -> Self {
        circleStrokeColor = newValue
        return self
    }

    /// The opacity of the circle's stroke.
    /// Default value: 1. Value range: [0, 1]
    public func circleStrokeOpacity(_ newValue: Double) -> Self {
        circleStrokeOpacity = newValue
        return self
    }

    /// The width of the circle's stroke. Strokes are placed outside of the `circle-radius`.
    /// Default value: 0. Minimum value: 0.
    public func circleStrokeWidth(_ newValue: Double) -> Self {
        circleStrokeWidth = newValue
        return self
    }

    /// Adds a handler for tap gesture on current annotation.
    ///
    /// The handler should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    ///
    /// - Parameters:
    ///   - handler: A handler for tap gesture.
    public func onTapGesture(handler: @escaping (MapContentGestureContext) -> Bool) -> Self {
        tapHandler = handler
        return self
    }

    /// Adds a handler for tap gesture on current annotation.
    ///
    /// - Parameters:
    ///   - handler: A handler for tap gesture.
    public func onTapGesture(handler: @escaping () -> Void) -> Self {
        return onTapGesture(handler: { _ in
            handler()
            return true
        })
    }

    /// Adds a handler for long press gesture on current annotation.
    ///
    /// The handler should return `true` if the gesture is handled, or `false` to propagate it to the annotations or layers below.
    ///
    /// - Parameters:
    ///   - handler: A handler for long press gesture.
    public func onLongPressGesture(handler: @escaping (MapContentGestureContext) -> Bool) -> Self {
        longPressHandler = handler
        return self
    }

    /// Adds a handler for long press gesture on current annotation.
    ///
    /// - Parameters:
    ///   - handler: A handler for long press gesture.
    public func onLongPressGesture(handler: @escaping () -> Void) -> Self {
        return onLongPressGesture(handler: { _ in
            handler()
            return true
        })
    }
}
#endif
#endif
