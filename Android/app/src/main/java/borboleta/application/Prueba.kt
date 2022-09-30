package borboleta.application

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase


class Prueba : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        auth = Firebase.auth
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_prueba)
        val b = findViewById<Button>(R.id.botonprueba)
        val r = findViewById<Button>(R.id.register)
        val t1 = findViewById<TextInputEditText>(R.id.texto1) as EditText
        val t2 = findViewById<TextInputEditText>(R.id.texto2) as EditText

        r.setOnClickListener {
            auth.createUserWithEmailAndPassword(t1.text.toString(), t2.text.toString())
                .addOnCompleteListener(this) { task ->
                    if (task.isSuccessful) {
                        // Sign in success, update UI with the signed-in user's information
                        Log.d("success", "createUserWithEmail:success")
                        val user = auth.currentUser
                        /*updateUI(user)*/
                    } else {
                        // If sign in fails, display a message to the user.
                        Log.w("failure", "createUserWithEmail:failure", task.exception)
                        /*Toast.makeText(baseContext, "Authentication failed.",
                            Toast.LENGTH_SHORT).show()
                        updateUI(null)*/
                    }
                }
        }

        b.setOnClickListener {
            Log.d("myTag", "This is my message");

            auth.signInWithEmailAndPassword(t1.text.toString(), t2.text.toString()).addOnCompleteListener(this) { task ->
                Log.d("dd", "entre a la funcion")
                Log.d("texto1", t1.text.toString())
                Log.d("texto2", t2.text.toString())

                if (task.isSuccessful) {
                    // Sign in success, update UI with the signed-in user's information
                    Log.d("success", "signInWithEmail:success")
                    val user = auth.currentUser
                    /*updateUI(user)*/
                } else {
                    // If sign in fails, display a message to the user.
                    Log.w("fail", "signInWithEmail:failure", task.exception)
                    /*updateUI(null)*/
                }
            }
        }
    }
}
