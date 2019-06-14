//
//  XYZColorDelta+FMAOperation.swift
//

import Foundation

public extension XYZColorDelta {
  
  @inlinable
  static func +(
    lhs: XYZColorDelta<Representation>,
    rhs: (Representation,XYZColorDelta<Representation>)) -> XYZColorDelta<Representation> {
    return lhs.adding(
      rhs.1,
      multipliedBy: rhs.0
    )
  }
  
  @inlinable
  static func +=(
    lhs: inout XYZColorDelta<Representation>,
    rhs: (Representation,XYZColorDelta<Representation>)) {
    return lhs.formAddition(
      of: rhs.1,
      multipliedBy: rhs.0
    )
  }
  
  @inlinable
  func adding(
    _ other: XYZColorDelta<Representation>,
    multipliedBy factor: Representation) -> XYZColorDelta<Representation> {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(factor.isFinite)
    pedantic_assert(self.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return XYZColorDelta<Representation>(
      storage: self._storage.addingProduct(
        other._storage,
        factor
      )
    )
  }
  
  @inlinable
  mutating func formAddition(
    of other: XYZColorDelta<Representation>,
    multipliedBy factor: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(other.isValid)
    pedantic_assert(factor.isFinite)
    pedantic_assert(self.isValid)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage.addProduct(
      other._storage,
      factor
    )
  }
  
}
