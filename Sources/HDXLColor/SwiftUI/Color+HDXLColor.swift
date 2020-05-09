//
//  Color+HDXLColor.swift
//

import Foundation
import simd
import SwiftUI
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension Color {
  
  // ------------------------------------------------------------------------ //
  // MARK: sRGBColor Support
  // ------------------------------------------------------------------------ //
  
  @inlinable
  init(from sRGB: sRGBColor<Double>, opacity: Double = 1.0) {
    self.init(
      .sRGB,
      red: sRGB.r,
      green: sRGB.g,
      blue: sRGB.b,
      opacity: opacity
    )
  }

  @inlinable
  init(from sRGB: sRGBColor<Float>, opacity: Float = 1.0) {
    self.init(
      .sRGB,
      red: Double(sRGB.r),
      green: Double(sRGB.g),
      blue: Double(sRGB.b),
      opacity: Double(opacity)
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: LinearRGBColor Support
  // ------------------------------------------------------------------------ //

  @inlinable
  init(from linearRGB: LinearRGBColor<Double>, opacity: Double = 1.0) {
    self.init(
      .sRGBLinear,
      red: linearRGB.r,
      green: linearRGB.g,
      blue: linearRGB.b,
      opacity: opacity
    )
  }

  @inlinable
  init(from linearRGB: LinearRGBColor<Float>, opacity: Float = 1.0) {
    self.init(
      .sRGBLinear,
      red: Double(linearRGB.r),
      green: Double(linearRGB.g),
      blue: Double(linearRGB.b),
      opacity: Double(opacity)
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: XYZColor Support
  // ------------------------------------------------------------------------ //

  @inlinable
  init(from xyz: XYZColor<Double>, opacity: Double = 1.0) {
    self.init(
      from: LinearRGBColor<Double>(from: xyz),
      opacity: opacity
    )
  }

  @inlinable
  init(from xyz: XYZColor<Float>, opacity: Float = 1.0) {
    self.init(
      from: LinearRGBColor<Float>(from: xyz),
      opacity: opacity
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: LUVColor Support
  // ------------------------------------------------------------------------ //

  @inlinable
  init(from luv: LUVColor<Double>, opacity: Double = 1.0) {
    self.init(
      from: LinearRGBColor<Double>(from: luv),
      opacity: opacity
    )
  }

  @inlinable
  init(from luv: LUVColor<Float>, opacity: Float = 1.0) {
    self.init(
      from: LinearRGBColor<Float>(from: luv),
      opacity: opacity
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: LCHColor Support
  // ------------------------------------------------------------------------ //

  @inlinable
  init(from lch: LCHColor<Double>, opacity: Double = 1.0) {
    self.init(
      from: LinearRGBColor<Double>(from: lch),
      opacity: opacity
    )
  }

  @inlinable
  init(from lch: LCHColor<Float>, opacity: Float = 1.0) {
    self.init(
      from: LinearRGBColor<Float>(from: lch),
      opacity: opacity
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: PureSpectralColor Support
  // ------------------------------------------------------------------------ //
  
  @inlinable
  init(
    fromMultilobeApproximationOf pureSpectralColor: PureSpectralColor<Double>,
    opacity: Double = 1.0) {
    self.init(
      from: LinearRGBColor<Double>(fromMultilobeApproximationOf: pureSpectralColor),
      opacity: opacity
    )
  }

  @inlinable
  init(
    fromMultilobeApproximationOf pureSpectralColor: PureSpectralColor<Float>,
    opacity: Float = 1.0) {
    self.init(
      from: LinearRGBColor<Float>(fromMultilobeApproximationOf: pureSpectralColor),
      opacity: opacity
    )
  }


}
