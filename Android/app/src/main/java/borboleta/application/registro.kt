package borboleta.application
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.Button
import android.widget.EditText
import android.widget.ImageButton
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.SetOptions
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class registro : AppCompatActivity() {
    //Trayendo Firebase
    private lateinit var auth: FirebaseAuth
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro)
        //Firebase Authentication
        auth = Firebase.auth
        var db = Firebase.firestore

        //Variables
        val getusername = findViewById<TextInputEditText>(R.id.inputnombre)
        val getemail = findViewById<TextInputEditText>(R.id.inputcorreo)
        val getpassword = findViewById<TextInputEditText>(R.id.inputcontra)
        val getconfirmation = findViewById<TextInputEditText>(R.id.inputconfirma)

        //Screen movement
        val btnRegisterSecond = findViewById<ImageButton>(R.id.nextbutton)
        btnRegisterSecond.setOnClickListener(){
            //if Función para confirmar contraseña
            if(getpassword.text.toString() == getconfirmation.text.toString()){
                auth.createUserWithEmailAndPassword(getemail.text.toString(), getpassword.text.toString())
                    .addOnCompleteListener(this) { task ->
                        if (task.isSuccessful) {
                            // Sign in success, update UI with the signed-in user's information
                            Log.d("success", "createUserWithEmail:success")
                            val user = auth.currentUser

                            var docData = object{
                                var data = object{
                                    var name : String = getusername.text.toString()
                                }
                            }

                            db.collection("users").document(user?.email.toString())
                                .set(docData)
                            /*updateUI(user)*/

                            //AQUI PASAMOS A REGISTRO 2
                            startActivity(Intent(this, registro2::class.java))
                        } else {
                            // If sign in fails, display a message to the user.
                            Log.w("failure", "createUserWithEmail:failure", task.exception)
                            /*Toast.makeText(baseContext, "Authentication failed.",
                                Toast.LENGTH_SHORT).show()
                            updateUI(null)*/
                        }
                    }
            }else{
                Log.w("failure", "did not match")
            }
        }

        //Regreso a Login
        val btnRegisterBack = findViewById<ImageButton>(R.id.backbutton)
        btnRegisterBack.setOnClickListener(){
            startActivity(Intent(this, Login::class.java))
        }


    }


}
