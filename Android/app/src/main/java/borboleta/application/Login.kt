package borboleta.application

import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase

@Suppress("DEPRECATION")
class Login : AppCompatActivity() {
    //Trayendo Firebase
    private lateinit var auth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
        //Firebase Authentication
        auth = Firebase.auth

        val user = Firebase.auth.currentUser

        if(user!= null){
            println(user.email)
            startActivity(Intent(this, Home::class.java))
        }

        //Variables
        val btnLogIn = findViewById<Button>(R.id.ButtonLogin)
        val username = findViewById<EditText>(R.id.EmailLogin)
        val password = findViewById<EditText>(R.id.PasswordLogin)

        //Función de Firebase para loggearse
        btnLogIn.setOnClickListener {
            Log.d("myTag", "This is my message")
            auth.signInWithEmailAndPassword(username.text.toString(), password.text.toString()).addOnCompleteListener(this) { task ->
                //For debbuging
                Log.d("dd", "entre a la funcion")
                Log.d("texto1", username.text.toString())
                Log.d("texto2", password.text.toString())

                if (task.isSuccessful) {
                    // Sign in success, update UI with the signed-in user's information
                    Log.d("success", "signInWithEmail:success")
                    startActivity(Intent(this, Home::class.java))

                    /* val user = auth.currentUser*/
                    /*updateUI(user)*/
                } else {
                    // If sign in fails, display a message to the user.
                    Log.w("fail", "signInWithEmail:failure", task.exception)
                    /*updateUI(null)*/
                }
                //Esta lleva a home
            }
        }

        //GO TO REGISTRATION
        val btnRegister = findViewById<Button>(R.id.RegistroLogin)
        btnRegister.setOnClickListener(){
            startActivity(Intent(this, registro::class.java))
        }

        //Fullscreen
        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
        )
    }

}