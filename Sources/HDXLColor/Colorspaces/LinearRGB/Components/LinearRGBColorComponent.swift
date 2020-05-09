//
//  LinearRGBColorComponents.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLLinearRGBColorComponent)
public enum LinearRGBColorComponent : Int {
  
  case r = 0
  case g = 1
  case b = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : Equatable {
  
  @inlinable
  public static func ==(
    lhs: LinearRGBColorComponent,
    rhs: LinearRGBColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: LinearRGBColorComponent,
    rhs: LinearRGBColorComponent) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  @inlinable
  public static func >(
    lhs: LinearRGBColorComponent,
    rhs: LinearRGBColorComponent) -> Bool {
    return lhs.rawValue > rhs.rawValue
  }

  @inlinable
  public static func <=(
    lhs: LinearRGBColorComponent,
    rhs: LinearRGBColorComponent) -> Bool {
    return lhs.rawValue <= rhs.rawValue
  }

  @inlinable
  public static func >=(
    lhs: LinearRGBColorComponent,
    rhs: LinearRGBColorComponent) -> Bool {
    return lhs.rawValue >= rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : CustomStringConvertible {
  
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
// MARK: LinearRGBColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .r:
        return "LinearRGBColorComponent.r"
      case .g:
        return "LinearRGBColorComponent.g"
      case .b:
        return "LinearRGBColorComponent.b"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - Codable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: LinearRGBColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension LinearRGBColorComponent : CaseIterable {
  
  public typealias AllCases = [LinearRGBColorComponent]
  
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
