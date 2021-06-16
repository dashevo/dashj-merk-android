package org.dashj.merk.android

import org.junit.Test

import org.junit.Assert.*
import org.dashj.MerkVerifyProof

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class ExampleUnitTest {
    @Test
    fun loadLibrary() {
        MerkVerifyProof.init()
    }
}