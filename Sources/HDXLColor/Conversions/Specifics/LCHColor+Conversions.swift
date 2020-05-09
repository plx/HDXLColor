//
//  LCHColor+Conversions.swift
//  

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension LCHColor {

  @inlinable
  init(from sRGB: sRGBColor<Representation>) {
    self.init(
      storage: sRGB
        .storage
        .removingSRGBGamma()
        .convertedFromLinearRGBToXYZ()
        .convertedFromXYZToLUV()
        .convertedFromLUVToLCH()
    )
  }

  @inlinable
  init(from linearRGB: LinearRGBColor<Representation>) {
    self.init(
      storage: linearRGB
        .storage
        .convertedFromLinearRGBToXYZ()
        .convertedFromXYZToLUV()
        .convertedFromLUVToLCH()
    )
  }

  @inlinable
  init(from xyz: XYZColor<Representation>) {
    self.init(
      storage: xyz
        .storage
        .convertedFromXYZToLUV()
        .convertedFromLUVToLCH()
    )
  }
  
  @inlinable
  init(from luv: LUVColor<Representation>) {
    self.init(
      storage: luv
        .storage
        .convertedFromLUVToLCH()
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
        .convertedFromLUVToLCH()
    )
  }

}
