package com.saulo.dev.offshorefx

data class OffshoreFxModel(val accountNumber: String) {
    companion object {
        fun fromMap(map: Map<String, Any>?): OffshoreFxModel? {
            if (map == null) return null
            return OffshoreFxModel(
                accountNumber = map["accountNumber"] as? String ?: "",
            )
        }
    }
}
