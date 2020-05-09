//
//  MathHax.swift
//

import Foundation
import HDXLCommonUtilities

internal extension ExtendedFloatingPointMath {
  
  @inlinable
  init(_adding a: Self, _ b: Self) {
    self = 0
    self._formAddition(of: a)
    self._formAddition(of: b)
  }

  @inlinable
  init(_adding a: Self, _ b: Self, _ c: Self) {
    self = 0
    self._formAddition(of: a)
    self._formAddition(of: b)
    self._formAddition(of: c)
  }

  @inlinable
  func _squared() -> Self {
    return self._multiplied(by: self)
  }

  @inlinable
  func _negated() -> Self {
    return -self
  }

  @inlinable
  mutating func _formNegation() {
    self =  -self
  }
  
  @inlinable
  func _inverted() -> Self {
    return Self(1) / self
  }

  @inlinable
  mutating func _formInverse() {
    self = self._inverted()
  }

  @inlinable
  func _adding(_ other: Self) -> Self {
    return self + other
  }

  @inlinable
  mutating func _formAddition(of other: Self) {
    self += other
  }

  @inlinable
  func _subtracting(_ other: Self) -> Self {
    return self - other
  }

  @inlinable
  mutating func _formSubtraction(of other: Self) {
    self = self - other
  }

  @inlinable
  func _multiplied(by other: Self) -> Self {
    return self * other
  }

  @inlinable
  mutating func _formMultiplication(by other: Self) {
    self *= other
  }

  @inlinable
  func _divided(by other: Self) -> Self {
    return self / other
  }
  
  @inlinable
  mutating func _formDivision(by other: Self) {
    self /= other
  }
  
  @inlinable
  func _quasiDivided(by other: Self) -> Self {
    guard other != 0 else {
      return 0
    }
    return self._divided(by: other)
  }

  @inlinable
  mutating func _formQuasiDivision(by other: Self) {
    guard other != 0 else {
      self = 0
      return
    }
    self._formDivision(by: other)
  }

}
