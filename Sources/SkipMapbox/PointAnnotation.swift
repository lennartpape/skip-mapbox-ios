//
//  PointAnnotation.swift
//
//
//  Created by John Bent on 9/16/24.
//

import Foundation

#if SKIP || !os(macOS)

import Foundation
import SwiftUI
#if SKIP
import com.mapbox.geojson.Point
import com.mapbox.geojson.Geometry
import androidx.compose.ui.res.painterResource
import com.mapbox.maps.`extension`.compose.annotation.rememberIconImage
import com.mapbox.maps.`extension`.compose.annotation.IconImage
import android.graphics.BitmapFactory

public struct PointAnnotation: View, Equatable {
    /// Identifier for this annotation
    internal(set) public var id: String
    
    /// The point backing this annotation
    var point: Point
    
    @Composable override func ComposeContent(context: ComposeContext) {
        let _iconAnchor = remember { iconAnchor?.androidValue }
        let _image = remember { image }
        let _iconOffset = remember { iconOffset?.mutableList }
        let _iconRotate = remember { iconRotate }
        let _iconSize = remember { iconSize }
        let _iconTextFit = remember { iconTextFit?.androidValue }
        let _iconTextFitPadding = remember { iconTextFitPadding?.mutableList }
        let _symbolSortKey = remember { symbolSortKey }
        let _textAnchor = remember { textAnchor?.androidValue }
        let _textField = remember { textField }
        let _textJustify = remember { textJustify?.androidValue }
        let _textLetterSpacing = remember { textLetterSpacing }
        let _textLineHeight = remember { textLineHeight }
        let _textMaxWidth = remember { textMaxWidth }
        let _textOffset = remember { textOffset?.mutableList }
        let _textRadialOffset = remember { textRadialOffset }
        let _textRotate = remember { textRotate }
        let _textSize = remember { textSize }
        let _textTransform = remember { textTransform?.androidValue }
        let _iconColor = remember { iconColor?.javaColor }
        let _iconEmissiveStrength = remember { iconEmissiveStrength }
        let _iconHaloBlur = remember { iconHaloBlur }
        let _iconHaloColor = remember { iconHaloColor?.javaColor }
        let _iconHaloWidth = remember { iconHaloWidth }
        let _iconImageCrossFade = remember { iconImageCrossFade }
        let _iconOpacity = remember { iconOpacity }
        let _textColor = remember { textColor?.javaColor }
        let _textEmissiveStrength = remember { textEmissiveStrength }
        let _textHaloBlur = remember { textHaloBlur }
        let _textOpacity = remember { textOpacity }
        com.mapbox.maps.extension.compose.annotation.generated.PointAnnotation(
            point = point,
            onClick = { [weak self] annotation in self?.tapHandler?(MapContentGestureContext(point: annotation.point)) ?? false }
        ) {
            iconAnchor = _iconAnchor
            iconImage = IconImage(_image!.bitmap!)
            iconOffset = _iconOffset
            iconRotate = _iconRotate
            iconSize = _iconSize
            iconTextFit = _iconTextFit
            iconTextFitPadding = _iconTextFitPadding
            symbolSortKey = _symbolSortKey
            textAnchor = _textAnchor
            textField = _textField
            textJustify = _textJustify
            textLetterSpacing = _textLetterSpacing
            textLineHeight = _textLineHeight
            textMaxWidth = _textMaxWidth
            textOffset = _textOffset
            textRadialOffset = _textRadialOffset
            textRotate = _textRotate
            textSize = _textSize
            textTransform = _textTransform
            iconColor = _iconColor
            iconEmissiveStrength = _iconEmissiveStrength
            iconHaloBlur = _iconHaloBlur
            iconHaloColor = _iconHaloColor
            iconHaloWidth = _iconHaloWidth
            iconImageCrossFade = _iconImageCrossFade
            iconOpacity = _iconOpacity
            textColor = _textColor
            textEmissiveStrength = _textEmissiveStrength
            textHaloBlur = _textHaloBlur
            textOpacity = _textOpacity
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
    public var dragBeginHandler: ((inout PointAnnotation, MapContentGestureContext) -> Bool)?

    /// The handler is invoked when annotation is being dragged.
    ///
    /// The handler receives the `annotation` and the `context` parameters of the gesture:
    /// - Use the `annotation` inout property to update properties of the annotation.
    /// - The `context` contains position of the gesture.
    public var dragChangeHandler: ((inout PointAnnotation, MapContentGestureContext) -> Void)?

    /// The handler receives the `annotation` and the `context` parameters of the gesture:
    /// - Use the `annotation` inout property to update properties of the annotation.
    /// - The `context` contains position of the gesture.
    public var dragEndHandler: ((inout PointAnnotation, MapContentGestureContext) -> Void)?
    
    /// Create a circle annotation with a center coordinate and an optional identifier
    /// - Parameters:
    ///   - id: Optional identifier for this annotation
    ///   - centerCoordinate: Coordinate where this circle annotation should be centered
    ///   - isDraggable: Determines whether annotation can be manually moved around map
    ///   - isSelected: Passes the annotation's selection state
    public init(id: String = UUID().uuidString, coordinate: CLLocationCoordinate2D, isSelected: Bool = false, isDraggable: Bool = false) {
        self.id = id
        self.point = coordinate.point
        self.isSelected = isSelected
        self.isDraggable = isDraggable
    }
    
    // MARK: - Style Properties -

    /// Part of the icon placed closest to the anchor.
    /// Default value: "center".
     public var iconAnchor: IconAnchor?

    /// Name of image in sprite to use for drawing an image background.
     public var iconImage: String?

    /// Offset distance of icon from its anchor. Positive values indicate right and down, while negative values indicate left and up. Each component is multiplied by the value of `icon-size` to obtain the final offset in pixels. When combined with `icon-rotate` the offset will be as if the rotated direction was up.
    /// Default value: [0,0].
     public var iconOffset: [Double]?

    /// Rotates the icon clockwise.
    /// Default value: 0.
     public var iconRotate: Double?

    /// Scales the original size of the icon by the provided factor. The new pixel size of the image will be the original pixel size multiplied by `icon-size`. 1 is the original size; 3 triples the size of the image.
    /// Default value: 1. Minimum value: 0.
     public var iconSize: Double?

    /// Scales the icon to fit around the associated text.
    /// Default value: "none".
     public var iconTextFit: IconTextFit?

    /// Size of the additional area added to dimensions determined by `icon-text-fit`, in clockwise order: top, right, bottom, left.
    /// Default value: [0,0,0,0].
     public var iconTextFitPadding: [Double]?

    /// Sorts features in ascending order based on this value. Features with lower sort keys are drawn and placed first. When `icon-allow-overlap` or `text-allow-overlap` is `false`, features with a lower sort key will have priority during placement. When `icon-allow-overlap` or `text-allow-overlap` is set to `true`, features with a higher sort key will overlap over features with a lower sort key.
     public var symbolSortKey: Double?

    /// Part of the text placed closest to the anchor.
    /// Default value: "center".
     public var textAnchor: TextAnchor?

    /// Value to use for a text label. If a plain `string` is provided, it will be treated as a `formatted` with default/inherited formatting options. SDF images are not supported in formatted text and will be ignored.
    /// Default value: "".
     public var textField: String?

    /// Text justification options.
    /// Default value: "center".
     public var textJustify: TextJustify?

    /// Text tracking amount.
    /// Default value: 0.
     public var textLetterSpacing: Double?

    /// Text leading value for multi-line text.
    /// Default value: 1.2.
     public var textLineHeight: Double?

    /// The maximum line width for text wrapping.
    /// Default value: 10. Minimum value: 0.
     public var textMaxWidth: Double?

    /// Offset distance of text from its anchor. Positive values indicate right and down, while negative values indicate left and up. If used with text-variable-anchor, input values will be taken as absolute values. Offsets along the x- and y-axis will be applied automatically based on the anchor position.
    /// Default value: [0,0].
     public var textOffset: [Double]?

    /// Radial offset of text, in the direction of the symbol's anchor. Useful in combination with `text-variable-anchor`, which defaults to using the two-dimensional `text-offset` if present.
    /// Default value: 0.
     public var textRadialOffset: Double?

    /// Rotates the text clockwise.
    /// Default value: 0.
     public var textRotate: Double?

    /// Font size.
    /// Default value: 16. Minimum value: 0.
     public var textSize: Double?

    /// Specifies how to capitalize text, similar to the CSS `text-transform` property.
    /// Default value: "none".
     public var textTransform: TextTransform?

    /// The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
    /// Default value: "#000000".
     public var iconColor: StyleColor?

    /// Controls the intensity of light emitted on the source features.
    /// Default value: 1. Minimum value: 0.
     public var iconEmissiveStrength: Double?

    /// Fade out the halo towards the outside.
    /// Default value: 0. Minimum value: 0.
     public var iconHaloBlur: Double?

    /// The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
    /// Default value: "rgba(0, 0, 0, 0)".
     public var iconHaloColor: StyleColor?

    /// Distance of halo to the icon outline.
    /// Default value: 0. Minimum value: 0.
     public var iconHaloWidth: Double?

    /// Controls the transition progress between the image variants of icon-image. Zero means the first variant is used, one is the second, and in between they are blended together.
    /// Default value: 0. Value range: [0, 1]
     public var iconImageCrossFade: Double?

    /// The opacity at which the icon will be drawn.
    /// Default value: 1. Value range: [0, 1]
     public var iconOpacity: Double?

    /// The color with which the text will be drawn.
    /// Default value: "#000000".
     public var textColor: StyleColor?

    /// Controls the intensity of light emitted on the source features.
    /// Default value: 1. Minimum value: 0.
     public var textEmissiveStrength: Double?

    /// The halo's fadeout distance towards the outside.
    /// Default value: 0. Minimum value: 0.
     public var textHaloBlur: Double?

    /// The color of the text's halo, which helps it stand out from backgrounds.
    /// Default value: "rgba(0, 0, 0, 0)".
     public var textHaloColor: StyleColor?

    /// Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
    /// Default value: 0. Minimum value: 0.
     public var textHaloWidth: Double?

    /// The opacity at which the text will be drawn.
    /// Default value: 1. Value range: [0, 1]
     public var textOpacity: Double?

    // MARK: - Image Convenience -

    public var image: Image? {
        didSet {
            self.iconImage = image?.name
        }
    }
}

extension PointAnnotation {

    /// Part of the icon placed closest to the anchor.
    /// Default value: "center".
    public func iconAnchor(_ newValue: IconAnchor) -> Self {
        iconAnchor = newValue
        return self
    }

    /// Name of image in sprite to use for drawing an image background.
    public func iconImage(_ newValue: String) -> Self {
        iconImage = newValue
        return self
    }

    /// Offset distance of icon from its anchor. Positive values indicate right and down, while negative values indicate left and up. Each component is multiplied by the value of `icon-size` to obtain the final offset in pixels. When combined with `icon-rotate` the offset will be as if the rotated direction was up.
    /// Default value: [0,0].
    public func iconOffset(x: Double, y: Double) -> Self {
        iconOffset = [x, y]
        return self
    }

    /// Rotates the icon clockwise.
    /// Default value: 0.
    public func iconRotate(_ newValue: Double) -> Self {
        iconRotate = newValue
        return self
    }

    /// Scales the original size of the icon by the provided factor. The new pixel size of the image will be the original pixel size multiplied by `icon-size`. 1 is the original size; 3 triples the size of the image.
    /// Default value: 1. Minimum value: 0.
    public func iconSize(_ newValue: Double) -> Self {
        iconSize = newValue
        return self
    }

    /// Scales the icon to fit around the associated text.
    /// Default value: "none".
    public func iconTextFit(_ newValue: IconTextFit) -> Self {
        iconTextFit = newValue
        return self
    }

    /// Size of the additional area added to dimensions determined by `icon-text-fit`, in clockwise order: top, right, bottom, left.
    /// Default value: [0,0,0,0].
    public func iconTextFitPadding(_ padding: UIEdgeInsets) -> Self {
        iconTextFitPadding = [padding.top, padding.right, padding.bottom, padding.left]
        return self
    }

    /// Sorts features in ascending order based on this value. Features with lower sort keys are drawn and placed first. When `icon-allow-overlap` or `text-allow-overlap` is `false`, features with a lower sort key will have priority during placement. When `icon-allow-overlap` or `text-allow-overlap` is set to `true`, features with a higher sort key will overlap over features with a lower sort key.
    public func symbolSortKey(_ newValue: Double) -> Self {
        symbolSortKey = newValue
        return self
    }

    /// Part of the text placed closest to the anchor.
    /// Default value: "center".
    public func textAnchor(_ newValue: TextAnchor) -> Self {
        textAnchor = newValue
        return self
    }

    /// Value to use for a text label. If a plain `string` is provided, it will be treated as a `formatted` with default/inherited formatting options. SDF images are not supported in formatted text and will be ignored.
    /// Default value: "".
    public func textField(_ newValue: String) -> Self {
        textField = newValue
        return self
    }

    /// Text justification options.
    /// Default value: "center".
    public func textJustify(_ newValue: TextJustify) -> Self {
        textJustify = newValue
        return self
    }

    /// Text tracking amount.
    /// Default value: 0.
    public func textLetterSpacing(_ newValue: Double) -> Self {
        textLetterSpacing = newValue
        return self
    }

    /// Text leading value for multi-line text.
    /// Default value: 1.2.
    public func textLineHeight(_ newValue: Double) -> Self {
        textLineHeight = newValue
        return self
    }

    /// The maximum line width for text wrapping.
    /// Default value: 10. Minimum value: 0.
    public func textMaxWidth(_ newValue: Double) -> Self {
        textMaxWidth = newValue
        return self
    }

    /// Offset distance of text from its anchor. Positive values indicate right and down, while negative values indicate left and up. If used with text-variable-anchor, input values will be taken as absolute values. Offsets along the x- and y-axis will be applied automatically based on the anchor position.
    /// Default value: [0,0].
    public func textOffset(x: Double, y: Double) -> Self {
        textOffset = [x, y]
        return self
    }

    /// Radial offset of text, in the direction of the symbol's anchor. Useful in combination with `text-variable-anchor`, which defaults to using the two-dimensional `text-offset` if present.
    /// Default value: 0.
    public func textRadialOffset(_ newValue: Double) -> Self {
        textRadialOffset = newValue
        return self
    }

    /// Rotates the text clockwise.
    /// Default value: 0.
    public func textRotate(_ newValue: Double) -> Self {
        textRotate = newValue
        return self
    }

    /// Font size.
    /// Default value: 16. Minimum value: 0.
    public func textSize(_ newValue: Double) -> Self {
        textSize = newValue
        return self
    }

    /// Specifies how to capitalize text, similar to the CSS `text-transform` property.
    /// Default value: "none".
    public func textTransform(_ newValue: TextTransform) -> Self {
        textTransform = newValue
        return self
    }

    /// The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
    /// Default value: "#000000".
    public func iconColor(_ newValue: StyleColor) -> Self {
        iconColor = newValue
        return self
    }

    /// Controls the intensity of light emitted on the source features.
    /// Default value: 1. Minimum value: 0.
    public func iconEmissiveStrength(_ newValue: Double) -> Self {
        iconEmissiveStrength = newValue
        return self
    }

    /// Fade out the halo towards the outside.
    /// Default value: 0. Minimum value: 0.
    public func iconHaloBlur(_ newValue: Double) -> Self {
        iconHaloBlur = newValue
        return self
    }

    /// The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
    /// Default value: "rgba(0, 0, 0, 0)".
    public func iconHaloColor(_ newValue: StyleColor) -> Self {
        iconHaloColor = newValue
        return self
    }

    /// Distance of halo to the icon outline.
    /// Default value: 0. Minimum value: 0.
    public func iconHaloWidth(_ newValue: Double) -> Self {
        iconHaloWidth = newValue
        return self
    }

    /// Controls the transition progress between the image variants of icon-image. Zero means the first variant is used, one is the second, and in between they are blended together.
    /// Default value: 0. Value range: [0, 1]
    public func iconImageCrossFade(_ newValue: Double) -> Self {
        iconImageCrossFade = newValue
        return self
    }

    /// The opacity at which the icon will be drawn.
    /// Default value: 1. Value range: [0, 1]
    public func iconOpacity(_ newValue: Double) -> Self {
        iconOpacity = newValue
        return self
    }

    /// The color with which the text will be drawn.
    /// Default value: "#000000".
    public func textColor(_ newValue: StyleColor) -> Self {
        textColor = newValue
        return self
    }

    /// Controls the intensity of light emitted on the source features.
    /// Default value: 1. Minimum value: 0.
    public func textEmissiveStrength(_ newValue: Double) -> Self {
        textEmissiveStrength = newValue
        return self
    }

    /// The halo's fadeout distance towards the outside.
    /// Default value: 0. Minimum value: 0.
    public func textHaloBlur(_ newValue: Double) -> Self {
        textHaloBlur = newValue
        return self
    }

    /// The color of the text's halo, which helps it stand out from backgrounds.
    /// Default value: "rgba(0, 0, 0, 0)".
    public func textHaloColor(_ newValue: StyleColor) -> Self {
        textHaloColor = newValue
        return self
    }

    /// Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
    /// Default value: 0. Minimum value: 0.
    public func textHaloWidth(_ newValue: Double) -> Self {
        textHaloWidth = newValue
        return self
    }

    /// The opacity at which the text will be drawn.
    /// Default value: 1. Value range: [0, 1]
    public func textOpacity(_ newValue: Double) -> Self {
        textOpacity = newValue
        return self
    }

    /// Sets icon image.
    public func image(_ image: Image?) -> Self {
        self.image = image
        return self
    }

    /// Sets named image as icon.
    public func image(named name: String) -> Self {
        self.iconImage = name
        return self
    }
    
    public func image(systemName: String) -> Self {
        self.iconImage = systemName
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

extension PointAnnotation {
    public struct Image: Hashable {
        public var name: String
        public var bitmap: android.graphics.Bitmap

        public init(name: String, in bundle: Bundle) {
            self.name = name
            let path = imageResourceURL(name: name, bundle: bundle)!
            self.bitmap = BitmapFactory.decodeFile(path)
        }
        
        /// Find all the `.xcassets` resource for the given bundle
        private func assetContentsURLs(name: String, bundle: Bundle) -> [URL] {
            let resourceNames = bundle.resourcesIndex

            var resourceURLs: [URL] = []
            for resourceName in resourceNames {
                let components = resourceName.split(separator: "/").map({ String($0) })
                // return every *.xcassets/NAME/Contents.json
                if components.first?.hasSuffix(".xcassets") == true
                    && components.dropFirst().first == name
                    && components.last == "Contents.json",
                   let contentsURL = bundle.url(forResource: resourceName, withExtension: nil) {
                    resourceURLs.append(contentsURL)
                }
            }
            return resourceURLs
        }

        private func imageResourceURL(name: String, bundle: Bundle) -> String? {
            for dataURL in assetContentsURLs(name: "\(name).imageset", bundle: bundle) {
                return dataURL.absoluteString
            }

            return nil
        }

    }
}

/// Part of the icon placed closest to the anchor.
public struct IconAnchor {
    public let androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor

    public init(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor) {
        self.androidValue = androidValue
    }

    /// The center of the icon is placed closest to the anchor.
    public static let center = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.CENTER)

    /// The left side of the icon is placed closest to the anchor.
    public static let left = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.LEFT)

    /// The right side of the icon is placed closest to the anchor.
    public static let right = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.RIGHT)

    /// The top of the icon is placed closest to the anchor.
    public static let top = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.TOP)

    /// The bottom of the icon is placed closest to the anchor.
    public static let bottom = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.BOTTOM)

    /// The top left corner of the icon is placed closest to the anchor.
    public static let topLeft = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.TOP_LEFT)

    /// The top right corner of the icon is placed closest to the anchor.
    public static let topRight = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.TOP_RIGHT)

    /// The bottom left corner of the icon is placed closest to the anchor.
    public static let bottomLeft = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.BOTTOM_LEFT)

    /// The bottom right corner of the icon is placed closest to the anchor.
    public static let bottomRight = IconAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconAnchor.BOTTOM_RIGHT)
}

/// Scales the icon to fit around the associated text.
public struct IconTextFit {
    public let androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit

    public init(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit) {
        self.androidValue = androidValue
    }

    /// The icon is displayed at its intrinsic aspect ratio.
    public static let none = IconTextFit(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit.NONE)

    /// The icon is scaled in the x-dimension to fit the width of the text.
    public static let width = IconTextFit(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit.WIDTH)

    /// The icon is scaled in the y-dimension to fit the height of the text.
    public static let height = IconTextFit(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit.HEIGHT)

    /// The icon is scaled in both x- and y-dimensions.
    public static let both = IconTextFit(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.IconTextFit.BOTH)
}

/// Text justification options.
public struct TextJustify {
    public let androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify

    public init(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify) {
        self.androidValue = androidValue
    }

    /// The text is aligned towards the anchor position.
    public static let auto = TextJustify(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify.AUTO)

    /// The text is aligned to the left.
    public static let left = TextJustify(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify.LEFT)

    /// The text is centered.
    public static let center = TextJustify(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify.CENTER)

    /// The text is aligned to the right.
    public static let right = TextJustify(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextJustify.RIGHT)
}

/// Part of the text placed closest to the anchor.
public struct TextAnchor {
    public let androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor

    public init(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor) {
        self.androidValue = androidValue
    }

    /// The center of the text is placed closest to the anchor.
    public static let center = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.CENTER)

    /// The left side of the text is placed closest to the anchor.
    public static let left = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.LEFT)

    /// The right side of the text is placed closest to the anchor.
    public static let right = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.RIGHT)

    /// The top of the text is placed closest to the anchor.
    public static let top = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.TOP)

    /// The bottom of the text is placed closest to the anchor.
    public static let bottom = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.BOTTOM)

    /// The top left corner of the text is placed closest to the anchor.
    public static let topLeft = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.TOP_LEFT)

    /// The top right corner of the text is placed closest to the anchor.
    public static let topRight = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.TOP_RIGHT)

    /// The bottom left corner of the text is placed closest to the anchor.
    public static let bottomLeft = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.BOTTOM_LEFT)

    /// The bottom right corner of the text is placed closest to the anchor.
    public static let bottomRight = TextAnchor(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextAnchor.BOTTOM_RIGHT)

}

/// Specifies how to capitalize text, similar to the CSS `text-transform` property.
public struct TextTransform {
    public let androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextTransform

    public init(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextTransform) {
        self.androidValue = androidValue
    }

    /// The text is not altered.
    public static let none = TextTransform(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextTransform.NONE)

    /// Forces all letters to be displayed in uppercase.
    public static let uppercase = TextTransform(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextTransform.UPPERCASE)

    /// Forces all letters to be displayed in lowercase.
    public static let lowercase = TextTransform(androidValue: com.mapbox.maps.`extension`.style.layers.properties.generated.TextTransform.LOWERCASE)

}
#endif
#endif
