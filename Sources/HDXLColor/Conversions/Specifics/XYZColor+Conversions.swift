//
//  XYZColor+Conversions.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension XYZColor {
  
  @inlinable
  init(from sRGB: sRGBColor<Representation>) {
    self.init(
      storage: sRGB
        .storage
        .removingSRGBGamma()
        .convertedFromLinearRGBToXYZ()
    )
  }
  
  @inlinable
  init(from linearRGB: LinearRGBColor<Representation>) {
    self.init(
      storage: linearRGB
        .storage
        .convertedFromLinearRGBToXYZ()
    )
  }
  
  @inlinable
  init(from luv: LUVColor<Representation>) {
    self.init(
      storage: luv
        .storage
        .convertedFromLUVToXYZ()
    )
  }

  @inlinable
  init(from lch: LCHColor<Representation>) {
    self.init(
      storage: lch
        .storage
        .convertedFromLCHToLUV()
        .convertedFromLUVToXYZ()
    )
  }

  @inlinable
  init(from HSB: HSBColor<Representation>) {
    self.init(
      storage: HSB
        .storage
        .convertedFromHSBToLinearRGB()
        .convertedFromLinearRGBToXYZ()
    )
  }

}
