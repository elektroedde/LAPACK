//
//  main.swift
//  LAPACK
//
//  Created by Edvin Berling on 2026-03-05.
//

import Foundation
import Accelerate




let bValues: [Float] = [50, 150, 190]


let A: [[Float]] = [[3, 1, 0],
                    [1, 4, 2],
                    [0, 2, 5]]

let subdiagonalElements: [Float] = [A[0][1], A[1][2]]
let diagonalElements: [Float] = [A[0][0], A[1][1], A[2][2]]


// This is a symmetric positive definite tridiagonal matrix

let x = symmetric_positiveDefinite_tridiagonal(diagonalElements: diagonalElements, subdiagonalElements: subdiagonalElements, dimension: 3, b: bValues, rightHandSideCount: 1)

print("Symmetric positive definite tridiagonal: x = ", x ?? [])


