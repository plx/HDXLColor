//
//  ColorComponentRepresentation+ValueLevelAPI.swift
//

import Foundation

internal extension ColorComponentRepresentation {
  
  /// Returns `self` after the application of the sRGB gamma function.
  ///
  /// - note: Internal-only API b/c I don't want this logic exposed elswhere (you can still get it via the corresponding protocol).
  ///
  @inlinable
  func applyingSRGBGamma() -> Self {
    return Self.applySRGBGamma(to: self)
  }

  /// Returns `self` after removing the effects of the sRGB gamma function.
  ///
  /// - note: Internal-only API b/c I don't want this logic exposed elswhere (you can still get it via the corresponding protocol).
  ///
  @inlinable
  func removingSRGBGamma() -> Self {
    return Self.removeSRGBGamma(from: self)
  }
  
  /// In-place mutates `self` into `self` after the application of the sRGB gamma function.
  ///
  /// - note: Internal-only API b/c I don't want this logic exposed elswhere (you can still get it via the corresponding protocol).
  /// - note: This is *internal* so I can use `inPlace` if I want to use it!
  ///
  @inlinable
  mutating func inPlaceApplySRGBGamma() {
    Self.formSRGBGammaApplication(to: &self)
  }

  /// In-place mutates `self` into `self` after removing the sRGB gamma function.
  ///
  /// - note: Internal-only API b/c I don't want this logic exposed elswhere (you can still get it via the corresponding protocol).
  /// - note: This is *internal* so I can use `inPlace` if I want to use it!
  ///
  @inlinable
  mutating func inPlaceRemoveSRGBGamma() {
    Self.formSRGBGammaRemoval(from: &self)
  }

}
