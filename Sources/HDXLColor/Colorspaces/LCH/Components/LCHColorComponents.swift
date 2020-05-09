//
//  LCHColorComponents.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLLCHColorComponent)
public enum LCHColorComponent : Int {
  
  case l = 0
  case c = 1
  case h = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : Equatable {
  
  @inlinable
  public static func ==(
    lhs: LCHColorComponent,
    rhs: LCHColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: LCHColorComponent,
    rhs: LCHColorComponent) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }

  @inlinable
  public static func >(
    lhs: LCHColorComponent,
    rhs: LCHColorComponent) -> Bool {
    return lhs.rawValue > rhs.rawValue
  }

  @inlinable
  public static func <=(
    lhs: LCHColorComponent,
    rhs: LCHColorComponent) -> Bool {
    return lhs.rawValue <= rhs.rawValue
  }

  @inlinable
  public static func >=(
    lhs: LCHColorComponent,
    rhs: LCHColorComponent) -> Bool {
    return lhs.rawValue >= rhs.rawValue
  }

}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension LCHColorComponent : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      switch self {
      case .l:
        return ".l"
      case .c:
        return ".c"
      case .h:
        return ".h"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension LCHColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .l:
        return "LCHColorComponent.x"
      case .c:
        return "LCHColorComponent.c"
      case .h:
        return "LCHColorComponent.h"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - Codable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: LCHColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension LCHColorComponent : CaseIterable {
  
  public typealias AllCases = [LCHColorComponent]
  
  @inlinable
  public static var allCases: AllCases {
    get {
      return [
        .l,
        .c,
        .h
      ]
    }
  }
  
  
}
