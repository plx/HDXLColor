//
//  LinearRGBColor+PureSpectralColor.swift
//

import Foundation
import HDXLCommonUtilities

public extension LinearRGBColor {
  
  @inlinable
  init(fromMultilobeApproximationOf pureSpectralColor: PureSpectralColor<Representation>) {
    let approximateXYZColor: XYZColor<Representation> = XYZColor<Representation>(
      multilobeApproximationForWavelength: pureSpectralColor.wavelength.wavelengthInNM
    )
    let hue = approximateXYZColor.storage.extractHSBHueAssumingLinearRGBContents()
    self.init(
      from: HSBColor(
        hue: hue,
        saturation: pureSpectralColor.saturation,
        brightness: pureSpectralColor.brightness
      )
    )
  }
  
}
