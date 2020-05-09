//
//  SIMD+SRGBGammaFunctionSupport.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

internal extension SIMD3 where Scalar:ColorComponentRepresentation {
  
  // ------------------------------------------------------------------------ //
  // MARK: RGB-Related Operations - Out-of-Place
  // ------------------------------------------------------------------------ //
  
  /// Returns the result of componentwise-applying the sRGB gamma function.
  ///
  /// - note: Defined on `SIMD3` in hopes of swapping in a faster implementation soon.
  /// - note: Doing it componentwise is inefficient, but consider this (potentially) a placeholder.
  ///
  /// - todo: Locate a system-supplied fast version of this (and make it available) *or* see if there's a way to be faster doing this @ the SIMD level.
  ///
  @inlinable
  func applyingSRGBGamma() -> SIMD3<Scalar> {
    return SIMD3<Scalar>(
      self[0].applyingSRGBGamma(),
      self[1].applyingSRGBGamma(),
      self[2].applyingSRGBGamma()
    )
  }

  /// Returns the result of componentwise-removing the sRGB gamma function.
  ///
  /// - note: Defined on `SIMD3` in hopes of swapping in a faster implementation soon.
  /// - note: Doing it componentwise is inefficient, but consider this (potentially) a placeholder.
  /// 
  /// - todo: Locate a system-supplied fast version of this (and make it available) *or* see if there's a way to be faster doing this @ the SIMD level.
  ///
  @inlinable
  func removingSRGBGamma() -> SIMD3<Scalar> {
    return SIMD3<Scalar>(
      self[0].removingSRGBGamma(),
      self[1].removingSRGBGamma(),
      self[2].removingSRGBGamma()
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: RGB-Related Operations - Out-of-Place
  // ------------------------------------------------------------------------ //
  
  /// In-place applies the sRGB gamma function to `self`.
  ///
  /// - note: Defined on `SIMD3` in hopes of swapping in a faster implementation soon.
  /// - note: Doing it componentwise is inefficient, but consider this (potentially) a placeholder.
  /// - note: This is `internal` and thus I can use `inPlace` if I want.
  ///
  /// - todo: Locate a system-supplied fast version of this (and make it available) *or* see if there's a way to be faster doing this @ the SIMD level.
  ///
  @inlinable
  mutating func inPlaceApplySRGBGamma() {
    self.x.inPlaceApplySRGBGamma()
    self.y.inPlaceApplySRGBGamma()
    self.z.inPlaceApplySRGBGamma()
  }

  /// In-place removes the sRGB gamma function from `self`.
  ///
  /// - note: Defined on `SIMD3` in hopes of swapping in a faster implementation soon.
  /// - note: Doing it componentwise is inefficient, but consider this (potentially) a placeholder.
  /// - note: This is `internal` and thus I can use `inPlace` if I want.
  ///
  /// - todo: Locate a system-supplied fast version of this (and make it available) *or* see if there's a way to be faster doing this @ the SIMD level.
  ///
  @inlinable
  mutating func inPlaceRemoveSRGBGamma() {
    self.x.inPlaceRemoveSRGBGamma()
    self.y.inPlaceRemoveSRGBGamma()
    self.z.inPlaceRemoveSRGBGamma()
  }

}
