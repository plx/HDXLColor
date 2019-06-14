//
//  XYZColorDelta.swift
//

import Foundation
import simd
import HDXLCommonUtilities
import HDXLSIMDSupport
import HDXLInterpolation

// -------------------------------------------------------------------------- //
// MARK: XYZColor - Definition
// -------------------------------------------------------------------------- //

public struct XYZColorDelta<Representation:ColorComponentRepresentation> {
  
  public typealias Storage = SIMD3<Representation>
  
  @usableFromInline
  internal var _storage: Storage
  
  @inlinable
  public var storage: Storage {
    get {
      return self._storage
    }
  }
  
  @inlinable
  public var dx: Representation {
    get {
      return self._storage[XYZColorComponent.x]
    }
    set {
      self._storage[XYZColorComponent.x] = newValue
    }
  }

  @inlinable
  public var dy: Representation {
    get {
      return self._storage[XYZColorComponent.y]
    }
    set {
      self._storage[XYZColorComponent.y] = newValue
    }
  }

  @inlinable
  public var dz: Representation {
    get {
      return self._storage[XYZColorComponent.z]
    }
    set {
      self._storage[XYZColorComponent.z] = newValue
    }
  }
  
  @usableFromInline
  internal init(storage: Storage) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(storage.isFinite)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = storage
  }

  @inlinable
  public init(
    dx: Representation,
    dy: Representation,
    dz: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(dx.isFinite)
    pedantic_assert(dy.isFinite)
    pedantic_assert(dz.isFinite)
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    self._storage = Storage(
      x: dx,
      y: dy,
      z: dz
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Validatable
// -------------------------------------------------------------------------- //

extension XYZColorDelta : Validatable {
  
  @inlinable
  public var isValid: Bool {
    get {
      guard
        self._storage.isFinite else {
          return false
      }
      return true
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Equatable
// -------------------------------------------------------------------------- //

extension XYZColorDelta : Equatable {
  
  @inlinable
  public static func ==(
    lhs: XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage == rhs._storage
  }
  
  @inlinable
  public static func !=(
    lhs: XYZColorDelta<Representation>,
    rhs: XYZColorDelta<Representation>) -> Bool {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(lhs.isValid)
    pedantic_assert(rhs.isValid)
    // /////////////////////////////////////////////////////////////////////////
    return lhs._storage != rhs._storage
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Hashable
// -------------------------------------------------------------------------- //

extension XYZColorDelta : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    self._storage.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColorDelta : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    get {
      return "xyz-delta: (\(self.dx), \(self.dy), \(self.dz))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension XYZColorDelta : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    get {
      return "XYZColorDelta<\(String(reflecting: Representation.self))>(dx: (\(self.dx), dy: \(self.dy), dz: \(self.dz))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Codable
// -------------------------------------------------------------------------- //

extension XYZColorDelta : Codable where Representation:Codable {
  
  // synthesized ok
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - ExpressibleByArrayLiteral
// -------------------------------------------------------------------------- //

extension XYZColorDelta : ExpressibleByArrayLiteral {
  
  public typealias ArrayLiteralElement = Representation
  
  @inlinable
  public init(arrayLiteral elements: ArrayLiteralElement...) {
    // /////////////////////////////////////////////////////////////////////////
    defer { pedantic_assert(self.isValid) }
    // /////////////////////////////////////////////////////////////////////////
    guard
      elements.count == 3,
      elements.allSatisfy({$0.isFinite}) else {
      fatalError("Tried to construct a literal `XYZColorDelta<\(String(reflecting: Representation.self))>` with \(elements.count) elements (instead of 2): \(elements.description)!")
    }
    self.init(
      dx: elements[0],
      dy: elements[1],
      dz: elements[2]
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: XYZColorDelta - Blendable
// -------------------------------------------------------------------------- //

extension XYZColorDelta : Blendable {
  
  public typealias BlendingWeight = Representation
  
  @inlinable
  public init(
    byBlending first: XYZColorDelta<Representation>,
    weight firstWeight: Representation,
    with other: XYZColorDelta<Representation>,
    weight otherWeight: Representation) {
    // /////////////////////////////////////////////////////////////////////////
    pedantic_assert(first.isValid)
    pedantic_assert(firstWeight.isFiniteNonNegative)
    pedantic_assert(other.isValid)
    pedantic_assert(otherWeight.isFiniteNonNegative)
    // /////////////////////////////////////////////////////////////////////////
    self.init(
      storage: (
        (first._storage * firstWeight)
          +
          (other._storage * otherWeight)
      )
    )
  }
  
}
