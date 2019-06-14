//
//  XYZColorDelta+Addition.swift
//

import Foundation

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Addition
// -------------------------------------------------------------------------- //

public extension XYZColorDelta {
  
  @inlinable
  static func +(
    lhs: XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.adding(rhs)
  }
  
  @inlinable
  static func +=(
    lhs: inout XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    lhs.formAddition(of: rhs)
  }
  
  
  /// Returns the componentwise addition of `other` and `self`.
  @inlinable
  func adding(_ other: XYZColorDelta<Representation>) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColorDelta<Representation>(
      storage: self._storage + other._storage
    )
  }
  
  /// In-place adds `other` into `self`.
  @inlinable
  mutating func formAddition(of other: XYZColorDelta<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage += other._storage
  }
  
}
