//
//  XYZColor+VectorArithmetic.swift
//

import Foundation
import SwiftUI
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

extension XYZColor : AdditiveArithmetic {
  
  @inlinable
  public static var zero: XYZColor<Representation> {
    get {
      return XYZColor<Representation>(
        storage: Storage()
      )
    }
  }
  
  @inlinable
  public static func +(
    lhs: XYZColor<Representation>,
    rhs: XYZColor<Representation>) -> XYZColor<Representation> {
    return XYZColor<Representation>(
      storage: lhs._storage + rhs._storage
    )
  }
  
  @inlinable
  public static func +=(
    lhs: inout XYZColor<Representation>,
    rhs: XYZColor<Representation>) {
    lhs._storage += rhs._storage
  }
  
  @inlinable
  public static func -(
    lhs: XYZColor<Representation>,
    rhs: XYZColor<Representation>) -> XYZColor<Representation> {
    return XYZColor<Representation>(
      storage: lhs._storage - rhs._storage
    )
  }
  
  @inlinable
  public static func -=(
    lhs: inout XYZColor<Representation>,
    rhs: XYZColor<Representation>) {
    lhs._storage -= rhs._storage
  }

}

extension XYZColor : VectorArithmetic {
  @inlinable
  public var magnitudeSquared: Double {
    get {
      return Double(
        Representation.extractSquareLength(
          from: self._storage
        )
      )
    }
  }
  
  @inlinable
  public mutating func scale(by factor: Double) {
    self._storage *= Representation(factor)
  }
  
}
