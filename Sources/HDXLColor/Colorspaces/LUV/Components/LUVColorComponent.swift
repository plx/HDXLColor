//
//  LUVColorComponent.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLLUVColorComponent)
public enum LUVColorComponent : Int {
  
  case l = 0
  case u = 1
  case v = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : Equatable {
  
  @inlinable
  public static func ==(
    lhs: LUVColorComponent,
    rhs: LUVColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: LUVColorComponent,
    rhs: LUVColorComponent) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  @inlinable
  public static func >(
    lhs: LUVColorComponent,
    rhs: LUVColorComponent) -> Bool {
    return lhs.rawValue > rhs.rawValue
  }

  @inlinable
  public static func <=(
    lhs: LUVColorComponent,
    rhs: LUVColorComponent) -> Bool {
    return lhs.rawValue <= rhs.rawValue
  }

  @inlinable
  public static func >=(
    lhs: LUVColorComponent,
    rhs: LUVColorComponent) -> Bool {
    return lhs.rawValue >= rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension LUVColorComponent : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      switch self {
      case .l:
        return ".l"
      case .u:
        return ".u"
      case .v:
        return ".v"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension LUVColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .l:
        return "LUVColorComponent.x"
      case .u:
        return "LUVColorComponent.u"
      case .v:
        return "LUVColorComponent.v"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - Codable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: LUVColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension LUVColorComponent : CaseIterable {
  
  public typealias AllCases = [LUVColorComponent]
  
  @inlinable
  public static var allCases: AllCases {
    get {
      return [
        .l,
        .u,
        .v
      ]
    }
  }
  
  
}
