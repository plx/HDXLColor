//
//  ColorComponentRepresentation+LUVDefaultImplementations.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport

public extension ColorComponentRepresentation {

  @inlinable
  internal static var CIELUVKappa: Self {
    get {
      return 903.2962962
    }
  }
  
  @inlinable
  internal static var CIELUVEpsilon: Self {
    get {
      return 0.0088564516
    }
  }
  
  @inlinable
  static func prepareLForLUV(byConvertingYFromXYZ yFromXYZ: Self) -> Self {
    guard yFromXYZ > Self.CIELUVEpsilon else {
      return yFromXYZ._multiplied(by: Self.CIELUVKappa)
    }
    let sixteen:Self = 16.0
    let oneHundredSixteen:Self = 116.0
    let rooted:Self = cubeRoot(of: yFromXYZ)
    let rescaled:Self = rooted._multiplied(by: oneHundredSixteen)
    let shifted:Self = rescaled._subtracting(sixteen)
    return shifted
  }

  @inlinable
  static func formLForLUV(byConvertingYFromXYZ yFromXYZ: inout Self) {
    if yFromXYZ > Self.CIELUVEpsilon {
      yFromXYZ._formMultiplication(by: Self.CIELUVKappa)
    } else {
      let sixteen:Self = 16.0
      let oneHundredSixteen:Self = 116.0
      yFromXYZ.formCubeRoot()
      yFromXYZ._formMultiplication(by: oneHundredSixteen)
      yFromXYZ._formSubtraction(of: sixteen)
    }
  }

  @inlinable
  static func prepareYForXYZ(byConvertingLFromLUV lFromLUV: Self) -> Self {
    let eight:Self = 8.0
    guard lFromLUV > eight else {
      return lFromLUV._divided(by: Self.CIELUVKappa)
    }
    let sixteen:Self = 16.0
    let oneHundredSixteen:Self = 116.0
    let shiftedL:Self = lFromLUV._adding(sixteen)
    let renormalizedL:Self = shiftedL._divided(by: oneHundredSixteen)
    let squaredRenormalizedL:Self = renormalizedL._multiplied(by: renormalizedL)
    let cubedRenormalizedL:Self = renormalizedL._multiplied(by: squaredRenormalizedL)
    return cubedRenormalizedL
  }
  
  @inlinable
  static func formYForXYZ(byConvertingLFromLUV lFromLUV: inout Self) {
    let eight:Self = 8.0
    if lFromLUV <= eight {
      lFromLUV._formDivision(by: Self.CIELUVKappa)
    } else {
      let sixteen:Self = 16.0
      let oneHundredSixteen:Self = 116.0
      lFromLUV._formAddition(of: sixteen)
      lFromLUV._formDivision(by: oneHundredSixteen)
      let l:Self = lFromLUV._multiplied(by: lFromLUV)
      lFromLUV *= l
    }
  }
  

}

//public extension ColorComponentRepresentation {
//
//  @inlinable
//  internal static var CIELUVKappa: Self {
//    get {
//      return 903.2962962
//    }
//  }
//
//  @inlinable
//  internal static var CIELUVEpsilon: Self {
//    get {
//      return 0.0088564516
//    }
//  }
//
//  @inlinable
//  static func prepareLForLUV(byConvertingYFromXYZ yFromXYZ: Self) -> Self {
//    guard yFromXYZ > Self.CIELUVEpsilon else {
//      return yFromXYZ * Self.CIELUVKappa
//    }
//    let sixteen:Self = 16.0
//    let oneHundredSixteen:Self = 116.0
//    let rooted:Self = cubeRoot(of: yFromXYZ)
//    let rescaled:Self = rooted * oneHundredSixteen
//    let shifted:Self = rescaled - sixteen
//    return shifted
//  }
//
//  @inlinable
//  static func formLForLUV(byConvertingYFromXYZ yFromXYZ: inout Self) {
//    if yFromXYZ > Self.CIELUVEpsilon {
//      yFromXYZ *= Self.CIELUVKappa
//    } else {
//      let sixteen:Self = 16.0
//      let oneHundredSixteen:Self = 116.0
//      yFromXYZ.formCubeRoot()
//      yFromXYZ *= oneHundredSixteen
//      yFromXYZ -= sixteen
//    }
//  }
//
//  @inlinable
//  static func prepareYForXYZ(byConvertingLFromLUV lFromLUV: Self) -> Self {
//    let eight:Self = 8.0
//    guard lFromLUV > eight else {
//      return lFromLUV / Self.CIELUVKappa
//    }
//    let sixteen:Self = 16.0
//    let oneHundredSixteen:Self = 116.0
//    let shiftedL:Self = (lFromLUV + sixteen)
//    let renormalizedL:Self = shiftedL / oneHundredSixteen
//    let squaredRenormalizedL:Self = renormalizedL * renormalizedL
//    let cubedRenormalizedL:Self = renormalizedL * squaredRenormalizedL
//    return cubedRenormalizedL
//  }
//
//  @inlinable
//  static func formYForXYZ(byConvertingLFromLUV lFromLUV: inout Self) {
//    let eight:Self = 8.0
//    if lFromLUV <= eight {
//      lFromLUV /= Self.CIELUVKappa
//    } else {
//      let sixteen:Self = 16.0
//      let oneHundredSixteen:Self = 116.0
//      lFromLUV += sixteen
//      lFromLUV /= oneHundredSixteen
//      let l:Self = lFromLUV * lFromLUV
//      lFromLUV *= l
//    }
//  }
//
//
//}
