import Accelerate

func symmetric_positiveDefinite_banded(aBanded: [Float],
                                       dimension: Int,
                                       superdiagonalCount: Int,
                                       b: [Float],
                                       rightHandSideCount: Int) -> [Float]? {

    var info: __LAPACK_int = 0
    var x = b
    var mutableAb = aBanded

    withUnsafePointer(to: Int8("U".utf8.first!)) { uplo in
        withUnsafePointer(to: __LAPACK_int(dimension)) { n in
            withUnsafePointer(to: __LAPACK_int(superdiagonalCount)) { kd in
                withUnsafePointer(to: __LAPACK_int(rightHandSideCount)) { nrhs in
                    withUnsafePointer(to: __LAPACK_int(superdiagonalCount + 1)) { ldab in
                        spbsv_(uplo,
                               n,
                               kd,
                               nrhs,
                               &mutableAb,
                               ldab,
                               &x,
                               n,
                               &info)
                    }
                }
            }
        }
    }

    if info != 0 {
        NSLog("symmetric_positiveDefinite_banded error \(info)")
        return nil
    }

    return x
}
