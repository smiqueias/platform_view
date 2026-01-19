package com.saulo.dev.offshorefx

import android.content.Context
import android.util.AttributeSet
import android.view.ContextThemeWrapper
import android.view.LayoutInflater
import android.widget.Toast
import androidx.constraintlayout.widget.ConstraintLayout
import com.saulo.dev.offshorefx.databinding.ViewOffshoreFxBinding

class OffshoreFxView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : ConstraintLayout(context, attrs, defStyleAttr) {


    /// Interface para comunicar com a camada Flutter
    interface OffshoreFxCallback {
        fun onSuccess(data: Map<String, Any>)
        fun onError(errorMessage: String)
        fun onPaused()
    }

    private var callback: OffshoreFxCallback? = null

    fun setOffshoreFxCallback(callback: OffshoreFxCallback) {
        this.callback = callback
    }

    private val themedContext = ContextThemeWrapper(context, R.style.Theme_Android)
    private val binding: ViewOffshoreFxBinding =
        ViewOffshoreFxBinding.inflate(LayoutInflater.from(themedContext), this, true)

    init {
        setupListeners()
    }

    private fun setupListeners() {
        binding.btnConvert.setOnClickListener {
            val amountText = binding.etAmount.text.toString()

            if (amountText.isNotEmpty()) {
                performSimulation(amountText.toDouble())
            } else {
                binding.tilAmount.error = "Digite um valor"
            }
        }



        binding.btnCallbackSuccess.setOnClickListener {
            val successMessage = mapOf(
                "status" to "Operação realizada com sucesso",
            )
            callback?.onSuccess(successMessage)
        }

        binding.btnCallbackError.setOnClickListener {
            callback?.onError("Falha na conexão com o servidor offshore.")
        }

        binding.btnCallbackPaused.setOnClickListener {
            callback?.onPaused()
        }

    }

    private fun performSimulation(amount: Double) {
        binding.tilAmount.error = null

        val result = amount * 5.0
        Toast.makeText(context, "Convertendo $amount USD -> R$ $result", Toast.LENGTH_SHORT).show()
    }



    fun initWithData(data: OffshoreFxModel) {
        binding.tvSubtitle.text = "Conta: ${data.accountNumber}"
    }


    fun cleanup() {
        binding.btnConvert.setOnClickListener(null)
        binding.btnCallbackSuccess.setOnClickListener(null)
        binding.btnCallbackError.setOnClickListener(null)
        binding.btnCallbackPaused.setOnClickListener(null)
        callback = null
    }


}