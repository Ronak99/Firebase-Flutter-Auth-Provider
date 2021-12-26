package com.example.auth_provider_demo

import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.tasks.OnFailureListener
import com.google.android.gms.tasks.OnSuccessListener
import com.google.android.gms.tasks.Task
import com.google.firebase.auth.AuthResult
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.OAuthProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*


class MainActivity: FlutterActivity() {
    private val TAG = "MainActivity"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        val CHANNEL = "com.example.authproviderdemo/yahooauth"

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "yahooAuth") {
                _performYahooAuthentication();
            }
        }
    }

    fun _performYahooAuthentication(){
        Log.d(TAG, "Performing yahoo authentication")

        val provider: com.google.firebase.auth.OAuthProvider.Builder = OAuthProvider.newBuilder("yahoo.com")
        // Prompt user to re-authenticate to Yahoo.
        provider.addCustomParameter("prompt", "login")

        val scopes: ArrayList<String> = object : ArrayList<String>() {
            init {
                // Request access to Yahoo Mail API.
                add("mail-r")
                // This must be preconfigured in the app's API permissions.
                add("sdct-w")
            }
        }
        provider.scopes = scopes

        val firebaseAuth: FirebaseAuth = FirebaseAuth.getInstance()
        val pendingResultTask: Task<AuthResult>? = firebaseAuth.pendingAuthResult

        Log.d(TAG, "Got the pending result")

        if (pendingResultTask != null) {
            // There's something already here! Finish the sign-in for your user.
            pendingResultTask
                    .addOnSuccessListener{
                            OnSuccessListener<AuthResult?> {
                                Log.d(TAG, "Pending result success callback")
                                // User is signed in.
                                // IdP data available in
                                // authResult.getAdditionalUserInfo().getProfile().
                                // The OAuth access token can be retrieved:
                                // authResult.getCredential().getAccessToken().
                                // Yahoo OAuth ID token can be retrieved:
                                // authResult.getCredential().getIdToken().
                            }
                    }
                    .addOnFailureListener {
                        fun onFailure(e: Exception) {
                            // Handle failure.
                            Log.d(TAG, "Pending result failure callback")
                        }
                    }
        } else {
            Log.d(TAG, "Pending result was null")
            // There's no pending result so you need to start the sign-in flow.
            // See below.
        }
    }
}
