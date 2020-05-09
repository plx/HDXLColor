//
//  Float+ColorComponent.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

extension Float : ColorComponentRepresentation {

  @inlinable
  public static func extractSquareLength(from vector: SIMD3<Float>) -> Float {
    return simd_length_squared(vector)
  }

}
