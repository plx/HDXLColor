//
//  SIMD3+XYZConversionSupport.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

internal extension SIMD3 where Scalar:ColorComponentRepresentation {
  
  @inlinable
  static var linearRGBToXYZMatrix: Matrix3x3<Scalar> {
    get {
      /*
       0.4124564  0.3575761  0.1804375
       0.2126729  0.7151522  0.0721750
       0.0193339  0.1191920  0.9503041
       */
      return Matrix3x3<Scalar>(
        SIMD3<Scalar>(
          0.41239079926595,
          0.21263900587151,
          0.019330818715591
        ),
        SIMD3<Scalar>(
          0.35758433938387,
          0.71516867876775,
          0.11919477979462
        ),
        SIMD3<Scalar>(
          0.18048078840183,
          0.072192315360733,
          0.95053215224966
        )
      )
    }
  }

  @inlinable
  static var xyzToLinearRGBMatrix: Matrix3x3<Scalar> {
    get {
      /*
        3.2404542 -1.5371385 -0.4985314
       -0.9692660  1.8760108  0.0415560
        0.0556434 -0.2040259  1.0572252
       */
      return Matrix3x3<Scalar>(
        SIMD3<Scalar>(
          3.240969941904521,
          -0.96924363628087,
          0.019330818715591
        ),
        SIMD3<Scalar>(
          -1.537383177570093,
          1.87596750150772,
          0.11919477979462
        ),
        SIMD3<Scalar>(
          0.055630079696993,
          -0.20397695888897,
          1.056971514242878
        )
      )
    }
  }

  @inlinable
  func convertedFromLinearRGBToXYZ() -> SIMD3<Scalar> {
    return SIMD3<Scalar>.linearRGBToXYZMatrix * self
  }
  
  @inlinable
  func convertedFromXYZToLinearRGB() -> SIMD3<Scalar> {
    return SIMD3<Scalar>.xyzToLinearRGBMatrix * self
  }
  
  @inlinable
  mutating func inPlaceConvertFromLinearRGBToXYZ() {
    // TODO: add forgotten vector-matrix API to SIMD support, sigh
    self = SIMD3<Scalar>.linearRGBToXYZMatrix * self
  }

  @inlinable
  mutating func inPlaceConvertFromXYZToLinearRGB() {
    // TODO: add forgotten vector-matrix API to SIMD support, sigh
    self = SIMD3<Scalar>.xyzToLinearRGBMatrix * self
  }

}
