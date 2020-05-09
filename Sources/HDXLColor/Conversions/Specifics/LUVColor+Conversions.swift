//
//  LUVColor+Conversions.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension LUVColor {
  
  @inlinable
  init(from sRGB: sRGBColor<Representation>) {
    self.init(
      storage: sRGB
        .storage
        .removingSRGBGamma()
        .convertedFromLinearRGBToXYZ()
        .convertedFromXYZToLUV()
    )
  }

  @inlinable
  init(from linearRGB: LinearRGBColor<Representation>) {
    self.init(
      storage: linearRGB
        .storage
        .convertedFromLinearRGBToXYZ()
        .convertedFromXYZToLUV()
    )
  }

  @inlinable
  init(from xyz: XYZColor<Representation>) {
    self.init(
      storage: xyz
        .storage
        .convertedFromXYZToLUV()
    )
  }

  @inlinable
  init(from lch: LCHColor<Representation>) {
    self.init(
      storage: lch
        .storage
        .convertedFromLCHToLUV()
    )
  }
  
  @inlinable
  init(from HSB: HSBColor<Representation>) {
    self.init(
      storage: HSB
        .storage
        .convertedFromHSBToLinearRGB()
        .convertedFromLinearRGBToXYZ()
        .convertedFromXYZToLUV()
    )
  }

}
