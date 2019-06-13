//
//  XYZColorDelta+Subtraction.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Subtraction
// -------------------------------------------------------------------------- //

public extension XYZColorDelta {
  
  @inlinable
  static func -(
    lhs: XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.subtracting(rhs)
  }
  
  @inlinable
  static func -=(
    lhs: inout XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    lhs.formSubtraction(of: rhs)
  }
  
  
  /// Returns the componentwise subtraction of `other` from `self`.
  @inlinable
  func subtracting(_ other: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColorDelta<Representation>(
      storage: self._storage - other._storage
    )
  }
  
  /// In-place subtracts `other` from `self`.
  @inlinable
  mutating func formSubtraction(of other: XYZColorDelta<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage -= other._storage
  }
  
}
