//
//  XYZColorComponent.swift
//

import Foundation
import HDXLCommonUtilities

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - Definition
// -------------------------------------------------------------------------- //

@objc(HDXLXYZColorComponent)
public enum XYZColorComponent : Int {
  
  case x = 0
  case y = 1
  case z = 2
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - Equatable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : Equatable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - Comparable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : Comparable {
  
  @inlinable
  public static func <(
    lhs: XYZColorComponent,
    rhs: XYZColorComponent) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - Hashable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : Hashable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColorComponent : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      switch self {
      case .x:
        return ".x"
      case .y:
        return ".y"
      case .z:
        return ".z"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColorComponent : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      switch self {
      case .x:
        return "XYZColorComponent.x"
      case .y:
        return "XYZColorComponent.y"
      case .z:
        return "XYZColorComponent.z"
      }
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - Codable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : Codable {
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - RawRepresentable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : RawRepresentable {
  
  public typealias RawValue = Int
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorComponent - CaseIterable
// -------------------------------------------------------------------------- //

extension XYZColorComponent : CaseIterable {
  
  public typealias AllCases = [XYZColorComponent]
  
  @inlinable
  public static var allCases: AllCases {
    get {
      return [
        .x,
        .y,
        .z
      ]
    }
  }
  
  
}
