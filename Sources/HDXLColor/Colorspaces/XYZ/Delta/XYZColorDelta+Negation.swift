//
//  XYZColorDelta+Negation.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Negation
// -------------------------------------------------------------------------- //

public extension XYZColorDelta {
  
  @inlinable
  static prefix func -(
    lhs: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.negation()
  }
  
  /// Returns the componentwise negation of `self`.
  @inlinable
  func negation() -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColorDelta<Representation>(
      storage: -self._storage
    )
  }
  
  /// In-place negates `self`.
  @inlinable
  mutating func formNegation(of other: XYZColorDelta<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = -self._storage
  }
  
}
