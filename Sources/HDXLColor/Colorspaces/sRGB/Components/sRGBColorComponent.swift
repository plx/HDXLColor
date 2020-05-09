//
//  sRGBColorComponents.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLsRGBColorComponent)
public enum sRGBColorComponent : Int {
  
  case r = 0
  case g = 1
  case b = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : Equatable {
  
  @inlinable
  public static func ==(
    lhs: sRGBColorComponent,
    rhs: sRGBColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: sRGBColorComponent,
    rhs: sRGBColorComponent) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  @inlinable
  public static func >(
    lhs: sRGBColorComponent,
    rhs: sRGBColorComponent) -> Bool {
    return lhs.rawValue > rhs.rawValue
  }

  @inlinable
  public static func <=(
    lhs: sRGBColorComponent,
    rhs: sRGBColorComponent) -> Bool {
    return lhs.rawValue <= rhs.rawValue
  }

  @inlinable
  public static func >=(
    lhs: sRGBColorComponent,
    rhs: sRGBColorComponent) -> Bool {
    return lhs.rawValue >= rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      switch self {
      case .r:
        return ".r"
      case .g:
        return ".g"
      case .b:
        return ".b"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .r:
        return "sRGBColorComponent.r"
      case .g:
        return "sRGBColorComponent.g"
      case .b:
        return "sRGBColorComponent.b"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - Codable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: sRGBColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension sRGBColorComponent : CaseIterable {
  
  public typealias AllCases = [sRGBColorComponent]
  
  @inlinable
  public static var allCases: AllCases {
    get {
      return [
        .r,
        .g,
        .b
      ]
    }
  }
  
  
}
