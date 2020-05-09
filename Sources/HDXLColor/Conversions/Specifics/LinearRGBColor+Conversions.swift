//
//  LinearRGBColor+Conversions.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension LinearRGBColor {
  
  @inlinable
  init(from sRGB: sRGBColor<Representation>) {
    self.init(
      storage: sRGB
        .storage
        .removingSRGBGamma()
    )
  }
  
  @inlinable
  init(from xyz: XYZColor<Representation>) {
    self.init(
      storage: xyz
        .storage
        .convertedFromXYZToLinearRGB()
    )
  }

  @inlinable
  init(from luv: LUVColor<Representation>) {
    self.init(
      storage: luv
        .storage
        .convertedFromLUVToXYZ()
        .convertedFromXYZToLinearRGB()
    )
  }

  @inlinable
  init(from lch: LCHColor<Representation>) {
    self.init(
      storage: lch
        .storage
        .convertedFromLCHToLUV()
        .convertedFromLUVToXYZ()
        .convertedFromXYZToLinearRGB()
    )
  }

  @inlinable
  init(from HSB: HSBColor<Representation>) {
    self.init(
      storage: HSB
        .storage
        .convertedFromHSBToLinearRGB()
    )
  }

}

