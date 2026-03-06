//
//  main.swift
//  LAPACK
//
//  Created by Edvin Berling on 2026-03-05.
//

import Foundation
import Accelerate



do {
    let bValues: [Float] = [50, 150, 190]


    let A: [[Float]] = [[3, 1, 0],
                        [1, 4, 2],
                        [0, 2, 5]]

    let subdiagonalElements: [Float] = [A[0][1], A[1][2]]
    let diagonalElements: [Float] = [A[0][0], A[1][1], A[2][2]]


    // This is a symmetric positive definite tridiagonal matrix

    let x = symmetric_positiveDefinite_tridiagonal(diagonalElements: diagonalElements, subdiagonalElements: subdiagonalElements, dimension: 3, b: bValues, rightHandSideCount: 1)

    print("Symmetric positive definite tridiagonal: x = ", x ?? [])
}

do {
    let bValues: [Float] = [20, 150, 180]
    let abValues: [Float] = [ 0, 0, 3,
                              0, 1, 4,
                             -1, 2, 5]

    let x = symmetric_positiveDefinite_banded(aBanded: abValues,
                                              dimension: 3,
                                              superdiagonalCount: 2,
                                              b: bValues,
                                              rightHandSideCount: 1)

    print("Symmetric positive definite banded: x = ", x ?? [])
}

do {
    // Complex 3x3 system: A * x = b
    //
    // A = [ (2+1i)  (1+0i)  (0+1i) ]
    //     [ (0+1i)  (3+0i)  (1-1i) ]
    //     [ (1+0i)  (0+1i)  (2+0i) ]
    //
    // b = [ (1+4i) ]
    //     [ (4+1i) ]
    //     [ (3+4i) ]
    //
    // Solution: x = [ (1+1i), (1+0i), (1+1i) ]

    // Column-major, interleaved [re, im] pairs
    let a: [Float] = [
        2, 1,    0, 1,    1, 0,
        1, 0,    3, 0,    0, 1,
        0, 1,    1,-1,    2, 0
    ]

    // b as interleaved [re, im] pairs
    let b: [Float] = [
        1, 4,    4, 1,    3, 4
    ]

    let x = nonsymmetric_general_complex(a: a,
                                         dimension: 3,
                                         b: b,
                                         rightHandSideCount: 1)


    print("Complex nonsymmetric: x =", x ?? [])
}
