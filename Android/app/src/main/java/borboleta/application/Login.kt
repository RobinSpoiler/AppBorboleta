package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase
import kotlinx.android.synthetic.main.activity_login.*

@Suppress("DEPRECATION")
class Login : AppCompatActivity() {
    //Trayendo Firebase
    private lateinit var auth: FirebaseAuth



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
        //Firebase Authentication
        auth = Firebase.auth

        //Variables
        val btnLogIn = findViewById<Button>(R.id.ButtonLogin)


        btnLogIn.setOnClickListener { loginUser() }


    }

    private fun checkUser(){
        val currentUser = auth.currentUser

        if(currentUser != null){
            val intent = Intent(this, ListOfChatsActivity::class.java)
            intent.putExtra("user", currentUser.email)
            startActivity(intent)

            finish()
        }
    }
    private fun loginUser(){

        val username = EmailLogin.text.toString()
        val password = PasswordLogin.text.toString()

        auth.signInWithEmailAndPassword(username,
            password).addOnCompleteListener { task ->
            if(task.isSuccessful){
                checkUser()
            } else {
                task.exception?.let {
                    Toast.makeText(baseContext, it.message, Toast.LENGTH_LONG).show()
                }
            }

        }
    }



}