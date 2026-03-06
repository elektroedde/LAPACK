import Accelerate

/// Returns the _x_ in _Ax = b_ for a complex nonsymmetric coefficient matrix using `cgesv_`.
///
/// Complex values are stored as interleaved real/imaginary pairs,
/// so a 2x2 complex matrix has 8 Float elements: [re00, im00, re10, im10, re01, im01, re11, im11]
/// (column-major, each complex entry is 2 consecutive Floats).
func nonsymmetric_general_complex(a: [Float],
                                  dimension: Int,
                                  b: [Float],
                                  rightHandSideCount: Int) -> [Float]? {

    var info: __LAPACK_int = 0
    var x = b          // overwritten with solution
    var mutableA = a   // overwritten with LU factors
    var ipiv = [__LAPACK_int](repeating: 0, count: dimension)

    withUnsafePointer(to: __LAPACK_int(dimension)) { n in
        withUnsafePointer(to: __LAPACK_int(rightHandSideCount)) { nrhs in
            // Complex arrays must be passed as OpaquePointer
            mutableA.withUnsafeMutableBytes { aPtr in
                x.withUnsafeMutableBytes { bPtr in
                    cgesv_(n,
                           nrhs,
                           OpaquePointer(aPtr.baseAddress!),
                           n,
                           &ipiv,
                           OpaquePointer(bPtr.baseAddress!),
                           n,
                           &info)
                }
            }
        }
    }

    if info != 0 {
        NSLog("nonsymmetric_general_complex error \(info)")
        return nil
    }
    return x
}
