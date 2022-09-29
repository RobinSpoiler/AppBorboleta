package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.view.WindowManager
import android.widget.Button
import android.widget.Toast
import android.widget.Toolbar
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.ktx.Firebase

@Suppress("DEPRECATION")
class Login : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
        )

        val botonLogin = findViewById<Button>(R.id.registroLogin)
        val toolbar = findViewById<Toolbar>(R.id.toolbar_sign_up_activity)
        val botonSignup = findViewById<Button>(R.id.ButtonLogin)

        botonLogin.setOnClickListener{
            startActivity(Intent(this, registro::class.java))
        }
        botonSignup.setOnClickListener {
            registerUser()
        }
    }



    // no tocar esto es una barra de control
    /*private fun setSupportActionBar(toolbar: Toolbar?) {
        setSupportActionBar(toolbar)
        val actionBar = supportActionBar
        if(actionBar != null){
            actionBar.setDisplayHomeAsUpEnabled(true)
            actionBar.setHomeAsUpIndicator(R.drawable.ic_baseline_arrow_back_ios_24dp)
        }
    }*/

    private fun registerUser(){
        val name:String = R.id.CorreoLogin.toString()
        val email:String = R.id.EmailLogin.toString()
        val password:String = R.id.PasswordLogin.toString()

        if(validateForm(name, email, password)){
            Toast.makeText(
                this@Login,
                "fuck",
                Toast.LENGTH_SHORT
            ).show()
        }
    }

    private fun validateForm(name:String, email: String, password:String): Boolean {
        return when{
            TextUtils.isEmpty(name)->{
                print("please enter name")
                false
            }
            TextUtils.isEmpty(email)->{
                print("please enter name")
                false
            }else -> {
                true
            }
        }
    }
}