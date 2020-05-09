//
//  LCHColor+VectorArithmetic.swift
//

import Foundation
import SwiftUI
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

extension LCHColor : AdditiveArithmetic {
  
  @inlinable
  public static var zero: LCHColor<Representation> {
    get {
      return LCHColor<Representation>(
        storage: Storage()
      )
    }
  }
  
  @inlinable
  public static func +(
    lhs: LCHColor<Representation>,
    rhs: LCHColor<Representation>) -> LCHColor<Representation> {
    return LCHColor<Representation>(
      storage: lhs._storage + rhs._storage
    )
  }
  
  @inlinable
  public static func +=(
    lhs: inout LCHColor<Representation>,
    rhs: LCHColor<Representation>) {
    lhs._storage += rhs._storage
  }
  
  @inlinable
  public static func -(
    lhs: LCHColor<Representation>,
    rhs: LCHColor<Representation>) -> LCHColor<Representation> {
    return LCHColor<Representation>(
      storage: lhs._storage - rhs._storage
    )
  }
  
  @inlinable
  public static func -=(
    lhs: inout LCHColor<Representation>,
    rhs: LCHColor<Representation>) {
    lhs._storage -= rhs._storage
  }

}

extension LCHColor : VectorArithmetic {
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
