//
//  LUVColor+VectorArithmetic.swift
//

import Foundation
import SwiftUI
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

extension LUVColor : AdditiveArithmetic {
  
  @inlinable
  public static var zero: LUVColor<Representation> {
    get {
      return LUVColor<Representation>(
        storage: Storage()
      )
    }
  }
  
  @inlinable
  public static func +(
    lhs: LUVColor<Representation>,
    rhs: LUVColor<Representation>) -> LUVColor<Representation> {
    return LUVColor<Representation>(
      storage: lhs._storage + rhs._storage
    )
  }
  
  @inlinable
  public static func +=(
    lhs: inout LUVColor<Representation>,
    rhs: LUVColor<Representation>) {
    lhs._storage += rhs._storage
  }
  
  @inlinable
  public static func -(
    lhs: LUVColor<Representation>,
    rhs: LUVColor<Representation>) -> LUVColor<Representation> {
    return LUVColor<Representation>(
      storage: lhs._storage - rhs._storage
    )
  }
  
  @inlinable
  public static func -=(
    lhs: inout LUVColor<Representation>,
    rhs: LUVColor<Representation>) {
    lhs._storage -= rhs._storage
  }

}

extension LUVColor : VectorArithmetic {

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
