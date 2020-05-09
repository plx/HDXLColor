//
//  HSBColor+Conversions.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension HSBColor {

  @inlinable
  init(from sRGB: sRGBColor<Representation>) {
    self.init(
      storage: sRGB
        .storage
        .removingSRGBGamma()
        .convertedFromLinearRGBToHSB()
    )
  }

  @inlinable
  init(from linearRGB: LinearRGBColor<Representation>) {
    self.init(
      storage: linearRGB
        .storage
        .convertedFromLinearRGBToHSB()
    )
  }
  
  @inlinable
  init(from xyz: XYZColor<Representation>) {
    self.init(
      storage: xyz
        .storage
        .convertedFromXYZToLinearRGB()
        .convertedFromLinearRGBToHSB()
    )
  }
  
  @inlinable
  init(from luv: LUVColor<Representation>) {
    self.init(
      storage: luv
        .storage
        .convertedFromLUVToXYZ()
        .convertedFromXYZToLinearRGB()
        .convertedFromLinearRGBToHSB()
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
        .convertedFromLinearRGBToHSB()
    )
  }

}

