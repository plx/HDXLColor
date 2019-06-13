//
//  SIMD3+Attributes.swift
//

import Foundation
import simd
import HDXLCommonUtilities

internal extension SIMD3 where Scalar: BinaryFloatingPoint {
  
  @usableFromInline
  var isFinite: Bool {
    get {
      guard
        self[0].isFinite,
        self[1].isFinite,
        self[2].isFinite else {
          return false
      }
      return true
    }
  }

  @usableFromInline
  var isFiniteNonNegative: Bool {
    get {
      guard
        self[0].isFiniteNonNegative,
        self[1].isFiniteNonNegative,
        self[2].isFiniteNonNegative else {
          return false
      }
      return true
    }
  }

}
