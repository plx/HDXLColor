//
//  XYZColorDelta+Multiplication.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Multiplication
// -------------------------------------------------------------------------- //

public extension XYZColorDelta {
  
  @inlinable
  static func *(
    lhs: Representation,
    rhs: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    return XYZColorDelta<Representation>(
      storage: lhs * rhs._storage
    )
  }

  @inlinable
  static func *(
    lhs: XYZColorDelta<Representation>,
    rhs: Representation) -> XYZColorDelta<Representation> {
    return XYZColorDelta<Representation>(
      storage: lhs._storage * rhs
    )
  }
  
  @inlinable
  static func *=(
    lhs: inout XYZColorDelta<Representation>,
    rhs: Representation) {
    lhs._storage *= rhs
  }

  /// Returns the componentwise-multiplication of `self` by `factor`.
  @inlinable
  func multiplied(by factor: Representation) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(factor.isFinite)
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColorDelta<Representation>(
      storage: self._storage * factor
    )
  }
  
  /// In-place multiplies `self` by `factor`.
  @inlinable
  mutating func formMultiplication(by factor: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(factor.isFinite)
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage *= factor
  }
  
}
