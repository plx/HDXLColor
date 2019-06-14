//
//  XYZColor+Addition.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Addition
// -------------------------------------------------------------------------- //

public extension XYZColor {
  
  @inlinable
  static func +(
    lhs: XYZColor<Representation>,
    rhs: XYZColor<Representation>) -> XYZColor<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs.adding(rhs)
  }
  
  @inlinable
  static func +=(
    lhs: inout XYZColor<Representation>,
    rhs: XYZColor<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    lhs.formAddition(of: rhs)
  }
  

  /// Returns the componentwise addition of `other` and `self`.
  @inlinable
  func adding(_ other: XYZColor<Representation>) -> XYZColor<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColor<Representation>(
      storage: self._storage + other._storage
    )
  }
  
  /// In-place adds `other` into `self`.
  @inlinable
  mutating func formAddition(of other: XYZColor<Representation>) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage += other._storage
  }
  
}
