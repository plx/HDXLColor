//
//  HSBColorComponents.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLHSBColorComponent)
public enum HSBColorComponent : Int {
  
  case hue = 0
  case saturation = 1
  case brightness = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : Equatable {
  
  @inlinable
  public static func ==(
    lhs: HSBColorComponent,
    rhs: HSBColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: HSBColorComponent,
    rhs: HSBColorComponent) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  @inlinable
  public static func >(
    lhs: HSBColorComponent,
    rhs: HSBColorComponent) -> Bool {
    return lhs.rawValue > rhs.rawValue
  }

  @inlinable
  public static func <=(
    lhs: HSBColorComponent,
    rhs: HSBColorComponent) -> Bool {
    return lhs.rawValue <= rhs.rawValue
  }

  @inlinable
  public static func >=(
    lhs: HSBColorComponent,
    rhs: HSBColorComponent) -> Bool {
    return lhs.rawValue >= rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension HSBColorComponent : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      switch self {
      case .hue:
        return ".hue"
      case .saturation:
        return ".saturation"
      case .brightness:
        return ".brightness"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension HSBColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .hue:
        return "HSBColorComponent.hue"
      case .saturation:
        return "HSBColorComponent.saturation"
      case .brightness:
        return "HSBColorComponent.brightness"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - Codable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: HSBColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension HSBColorComponent : CaseIterable {
  
  public typealias AllCases = [HSBColorComponent]
  
  @inlinable
  public static var allCases: AllCases {
    get {
      return [
        .hue,
        .saturation,
        .brightness
      ]
    }
  }
  
  
}
