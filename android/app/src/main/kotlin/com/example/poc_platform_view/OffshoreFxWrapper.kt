package com.example.poc_platform_view

import android.content.Context
import android.os.Looper
import android.os.Handler
import android.view.View
import com.saulo.dev.offshorefx.OffshoreFxModel
import com.saulo.dev.offshorefx.OffshoreFxView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class OffshoreFxWrapper(
    context: Context, id: Int,
    messenger: BinaryMessenger,
    creationParams: Map<String, Any>?
) : PlatformView, OffshoreFxView.OffshoreFxCallback {

    private val methodChannel = MethodChannel(messenger, "offshore_fx_channel")

    private val offshoreFxView = OffshoreFxView(context)

    private val uiHandler = Handler(Looper.getMainLooper())

    override fun getView(): View = offshoreFxView

    init {
        offshoreFxView.setOffshoreFxCallback(this)

        OffshoreFxModel.fromMap(creationParams)?.let {
            data -> offshoreFxView.initWithData(data)
        }
    }

    override fun dispose() {

        offshoreFxView.clearFocus()
        offshoreFxView.cleanup()

        val parent = offshoreFxView.parent
        if (parent is android.view.ViewGroup) {
            parent.removeView(offshoreFxView)
        }
    }

    // --- Implementação da Interface OffshoreFxCallback ---
    override fun onSuccess(data: Map<String, Any>) {
        uiHandler.post {
            methodChannel.invokeMethod("onSuccess", data)
        }

    }

    override fun onError(errorMessage: String) {
        uiHandler.post {
            methodChannel.invokeMethod("onError", mapOf("message" to errorMessage))
        }

    }

    override fun onPaused() {
        uiHandler.post {
            methodChannel.invokeMethod("onPaused", null)
        }

    }
}

class OffshoreFxFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(
        context: Context,
        viewId: Int,
        args: Any?
    ): PlatformView {
        val params = args as? Map<String, Any>?
        return OffshoreFxWrapper(
            context,
            viewId,
            messenger,
            params,
        )
    }
}