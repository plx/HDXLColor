//
//  sRGBColor+Conversions.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension sRGBColor {

  @inlinable
  init(from linearRGB: LinearRGBColor<Representation>) {
    self.init(
      storage: linearRGB
        .storage
        .applyingSRGBGamma()
    )
  }
  
  @inlinable
  init(from xyz: XYZColor<Representation>) {
    self.init(
      storage: xyz
        .storage
        .convertedFromXYZToLinearRGB()
        .applyingSRGBGamma()
    )
  }
  
  @inlinable
  init(from luv: LUVColor<Representation>) {
    self.init(
      storage: luv
        .storage
        .convertedFromLUVToXYZ()
        .convertedFromXYZToLinearRGB()
        .applyingSRGBGamma()
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
        .applyingSRGBGamma()
    )
  }

  @inlinable
  init(from HSB: HSBColor<Representation>) {
    self.init(
      storage: HSB
        .storage
        .convertedFromHSBToLinearRGB()
        .applyingSRGBGamma()
    )
  }

}

