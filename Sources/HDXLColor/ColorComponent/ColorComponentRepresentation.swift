//
//  ColorComponent.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

/// Protocol for the types *usable* as color-component representations.
///
/// This exists, in part, b/c it's the natural place to include the color-conversion
/// mathematical formulas exactly once, while still reserving room for `Float`, `Double`,
/// etc., to use system-supplied, accelerated variants.
///
public protocol ColorComponentRepresentation : ExtendedFloatingPointMath & ExtendedSIMDScalar {
  
  // ------------------------------------------------------------------------ //
  // MARK: RGB-Related - Out-of-Place
  // ------------------------------------------------------------------------ //
  
  /// Applies the sRGB-standard gamma-function to a "presumed-linear" `value`.
  ///
  /// - parameter value: The value to-which to apply the gamma function used by the sRGB standard.
  ///
  /// - returns: `value` after applicaiton of the sRGB gamma function.
  ///
  /// - note: For use converting *from* `LinearRGBColor` to `sRGBColor`
  /// - note: Default implementation supplied.
  ///
  static func applySRGBGamma(to value: Self) -> Self
  
  /// "Un-applies" the sRGB-standard gamma-function from a "presumed-sRGB-gamma" `value`.
  ///
  /// - parameter value: The value from-which to remove the sRGB standard's gamma function.
  ///
  /// - returns: `value` after application of the inverse of the sRGB gamma function.
  ///
  /// - note: For use converting *from* `LinearRGBColor` to `sRGBColor`
  /// - note: Default implementation supplied.
  ///
  static func removeSRGBGamma(from value: Self) -> Self

  // ------------------------------------------------------------------------ //
  // MARK: RGB-Related - In-of-Place
  // ------------------------------------------------------------------------ //
  
  /// Applies the sRGB-standard gamma-function to a "presumed-linear" `value`.
  ///
  /// - parameter value: The value to-which to apply the gamma function used by the sRGB standard.
  ///
  /// - note: For use converting *from* `LinearRGBColor` to `sRGBColor`
  /// - note: Default implementation supplied.
  ///
  static func formSRGBGammaApplication(to value: inout Self)
  
  /// "Un-applies" the sRGB-standard gamma-function from a "presumed-sRGB-gamma" `value`.
  ///
  /// - parameter value: The value from-which to remove the sRGB standard's gamma function.
  ///
  /// - note: For use converting *from* `LinearRGBColor` to `sRGBColor`
  /// - note: Default implementation supplied.
  ///
  static func formSRGBGammaRemoval(from value: inout Self)

  static func prepareLForLUV(byConvertingYFromXYZ yFromXYZ: Self) -> Self
  static func formLForLUV(byConvertingYFromXYZ yFromXYZ: inout Self)
  
  static func prepareYForXYZ(byConvertingLFromLUV lFromLUV: Self) -> Self
  static func formYForXYZ(byConvertingLFromLUV lFromLUV: inout Self)
  
  static func extractSquareLength(from vector: SIMD3<Self>) -> Self

}

