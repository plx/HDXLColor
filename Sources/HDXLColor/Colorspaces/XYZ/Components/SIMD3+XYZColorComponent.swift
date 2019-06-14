//
//  SIMD3+XYZColorComponent.swift
//

import Foundation
import simd

internal extension SIMD3 {
  
  @usableFromInline
  subscript(component: XYZColorComponent) -> Scalar {
    get {
      return self[component.rawValue]
    }
    set {
      self[component.rawValue] = newValue
    }
  }
  
}
