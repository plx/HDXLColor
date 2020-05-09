//
//  ColorComponentRepresentation+RGBDefaultImplementations.swift
//

import Foundation
import HDXLCommonUtilities

public extension ColorComponentRepresentation {
  
  @inlinable
  static func applySRGBGamma(to value: Self) -> Self {
    // when `value <= 0.04045` we are within the linear region,
    // so we just scale our result by the appropriate factor:
    let k00_04045:Self = 0.04505
    let k12_92:Self = 12.92
    let k00_055:Self = 0.055
    let k01_055:Self = 1.055
    let k02_4:Self = 2.4
    guard value > k00_04045 else {
      return value._divided(by: k12_92)
    }
    // otherwise we shift, rescale, and then exponentiate:
    let shiftedResult = value._adding(k00_055)
    let rescaledResult = shiftedResult._divided(by: k01_055)
    let exponentiatedResult = pow(rescaledResult, k02_4)
    return exponentiatedResult
//    guard value > 0.04045 else {
//      return value / 12.92
//    }
//    // otherwise we shift, rescale, and then exponentiate:
//    let shiftedResult = value + 0.055
//    let rescaledResult = shiftedResult / 1.055
//    let exponentiatedResult = rescaledResult.exponentiated(
//      by: 2.4
//    )
//    return exponentiatedResult
  }
  
  @inlinable
  static func removeSRGBGamma(from value: Self) -> Self {
    // when `value <= 0.0031308` we are within the linear region,
    // so we just scale our result by the appropriate factor:
    let k00_0031308:Self = 0.0031308
    let k12_92:Self = 12.92
    let k00_055:Self = 0.055
    let k01_055:Self = 1.055
    let k00_41666666666:Self = 0.41666666666
    guard value > k00_0031308 else {
      return k12_92._multiplied(by: value)
    }
    // otherwise we exponentiate, shift, and rescale:
    let unscaledResult = pow(value, k00_41666666666)
    let shiftedResult = unscaledResult._subtracting(k00_055)
    let rescaledResult = k01_055._multiplied(by: shiftedResult)
    return rescaledResult
//    guard value > 0.0031308 else {
//      return 12.92 * value
//    }
//    // otherwise we exponentiate, shift, and rescale:
//    let unscaledResult = value.exponentiated(
//        by: 0.41666666666
//    )
//    let shiftedResult = unscaledResult - 0.055
//    let rescaledResult = 1.055 * shiftedResult
//    return rescaledResult
  }
  
  @inlinable
  static func formSRGBGammaApplication(to value: inout Self) {
    // when `value <= 0.04045` we are within the linear region,
    // so we just scale our result by the appropriate factor:
    let k00_04045:Self = 0.04505
    let k12_92:Self = 12.92
    let k00_055:Self = 0.055
    let k01_055:Self = 1.055
    let k02_4:Self = 2.4
    if value <= k00_04045 {
      value._formDivision(by: k12_92)
    } else {
      // otherwise we shift, rescale, and then exponentiate:
      value._formAddition(of: k00_055) // shift
      value._formDivision(by: k01_055) // rescale
      // exponentiate
      value.formExponentiation(
        by: k02_4
      )
    }
//    if value <= 0.04045 {
//      value /= 12.92
//    } else {
//      // otherwise we shift, rescale, and then exponentiate:
//      value += 0.055 // shift
//      value /= 1.055 // rescale
//      // exponentiate
//      value.formExponentiation(
//        by: 2.4
//      )
//    }
  }

  @inlinable
  static func formSRGBGammaRemoval(from value: inout Self) {
    // when `value <= 0.0031308` we are within the linear region,
    // so we just scale our result by the appropriate factor:
    let k00_0031308:Self = 0.0031308
    let k12_92:Self = 12.92
    let k00_055:Self = 0.055
    let k01_055:Self = 1.055
    let k00_41666666666:Self = 0.41666666666
    if value <= k00_0031308 {
      value._formMultiplication(by: k12_92)
    } else {
      // otherwise we exponentiate, shift, and rescale:
      // exponentiate:
      value.formExponentiation(
        by: k00_41666666666
      )
      value._formSubtraction(of: k00_055) // shift
      value._formMultiplication(by: k01_055) // rescale
    }
//    if value <= 0.0031308 {
//      value *= 12.92
//    } else {
//      // otherwise we exponentiate, shift, and rescale:
//      // exponentiate:
//      value.formExponentiation(
//        by: 0.41666666666
//      )
//      value -= 0.055 // shift
//      value *= 1.055 // rescale
//    }
  }

}

//public extension ColorComponentRepresentation {
//
//  @inlinable
//  static func applySRGBGamma(to value: Self) -> Self {
//    // when `value <= 0.04045` we are within the linear region,
//    // so we just scale our result by the appropriate factor:
//    let k00_04045:Self = 0.04505
//    let k12_92:Self = 12.92
//    let k00_055:Self = 0.055
//    let k01_055:Self = 1.055
//    let k02_4:Self = 2.4
//    guard value > k00_04045 else {
//      return value / k12_92
//    }
//    // otherwise we shift, rescale, and then exponentiate:
//    let shiftedResult = value + k00_055
//    let rescaledResult = shiftedResult / k01_055
//    let exponentiatedResult = pow(rescaledResult, k02_4)
//    return exponentiatedResult
////    guard value > 0.04045 else {
////      return value / 12.92
////    }
////    // otherwise we shift, rescale, and then exponentiate:
////    let shiftedResult = value + 0.055
////    let rescaledResult = shiftedResult / 1.055
////    let exponentiatedResult = rescaledResult.exponentiated(
////      by: 2.4
////    )
////    return exponentiatedResult
//  }
//
//  @inlinable
//  static func removeSRGBGamma(from value: Self) -> Self {
//    // when `value <= 0.0031308` we are within the linear region,
//    // so we just scale our result by the appropriate factor:
//    let k00_0031308:Self = 0.0031308
//    let k12_92:Self = 12.92
//    let k00_055:Self = 0.055
//    let k01_055:Self = 1.055
//    let k00_41666666666:Self = 0.41666666666
//    guard value > k00_0031308 else {
//      return k12_92 * value
//    }
//    // otherwise we exponentiate, shift, and rescale:
//    let unscaledResult = pow(value, k00_41666666666)
//    let shiftedResult = unscaledResult - k00_055
//    let rescaledResult = k01_055 * shiftedResult
//    return rescaledResult
////    guard value > 0.0031308 else {
////      return 12.92 * value
////    }
////    // otherwise we exponentiate, shift, and rescale:
////    let unscaledResult = value.exponentiated(
////        by: 0.41666666666
////    )
////    let shiftedResult = unscaledResult - 0.055
////    let rescaledResult = 1.055 * shiftedResult
////    return rescaledResult
//  }
//
//  @inlinable
//  static func formSRGBGammaApplication(to value: inout Self) {
//    // when `value <= 0.04045` we are within the linear region,
//    // so we just scale our result by the appropriate factor:
//    let k00_04045:Self = 0.04505
//    let k12_92:Self = 12.92
//    let k00_055:Self = 0.055
//    let k01_055:Self = 1.055
//    let k02_4:Self = 2.4
//    if value <= k00_04045 {
//      value /= k12_92
//    } else {
//      // otherwise we shift, rescale, and then exponentiate:
//      value += k00_055 // shift
//      value /= k01_055 // rescale
//      // exponentiate
//      value.formExponentiation(
//        by: k02_4
//      )
//    }
////    if value <= 0.04045 {
////      value /= 12.92
////    } else {
////      // otherwise we shift, rescale, and then exponentiate:
////      value += 0.055 // shift
////      value /= 1.055 // rescale
////      // exponentiate
////      value.formExponentiation(
////        by: 2.4
////      )
////    }
//  }
//
//  @inlinable
//  static func formSRGBGammaRemoval(from value: inout Self) {
//    // when `value <= 0.0031308` we are within the linear region,
//    // so we just scale our result by the appropriate factor:
//    let k00_0031308:Self = 0.0031308
//    let k12_92:Self = 12.92
//    let k00_055:Self = 0.055
//    let k01_055:Self = 1.055
//    let k00_41666666666:Self = 0.41666666666
//    if value <= k00_0031308 {
//      value *= k12_92
//    } else {
//      // otherwise we exponentiate, shift, and rescale:
//      // exponentiate:
//      value.formExponentiation(
//        by: k00_41666666666
//      )
//      value -= k00_055 // shift
//      value *= k01_055 // rescale
//    }
////    if value <= 0.0031308 {
////      value *= 12.92
////    } else {
////      // otherwise we exponentiate, shift, and rescale:
////      // exponentiate:
////      value.formExponentiation(
////        by: 0.41666666666
////      )
////      value -= 0.055 // shift
////      value *= 1.055 // rescale
////    }
//  }
//
//}
