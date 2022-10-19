package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.FieldValue
import com.google.firebase.firestore.SetOptions
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class Profile : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_profile)
        //DATABASE
        var db = Firebase.firestore
        var navbar = findViewById<BottomNavigationView>(R.id.bottomNavigationView_navbar)
        navbar.menu.findItem(R.id.profile_icon).isChecked = true;
        navbar.setOnItemSelectedListener { item ->
            when (item.itemId) {
                R.id.home_icon -> {
                    // Respond to navigation item 1 click
                    startActivity(Intent(this, Home::class.java))
                    true
                }
                R.id.heart_icon -> {
                    // Respond to navigation item 2 click
                    startActivity(Intent(this, Psicologos::class.java))
                    true
                }
                R.id.message_icon -> {
                    // Respond to navigation item 2 click
                    startActivity(Intent(this, ActiveChats::class.java))
                    true
                }
                R.id.profile_icon -> {
                    // Respond to navigation item 2 click
                    startActivity(Intent(this, Profile::class.java))
                    true
                }
                else -> false
            }
        }



        //Funcionalidad
        var botonexit = findViewById<ImageButton>(R.id.logout_button_profile)
        botonexit.setOnClickListener(){
            Firebase.auth.signOut()
            startActivity(Intent(this, Login::class.java))
        }


        val user = auth.currentUser

        var editFields = findViewById<Button>(R.id.edit_button_profile)
        var nombre = findViewById<TextInputEditText>(R.id.profile_name)
        var number = findViewById<TextInputEditText>(R.id.profile_number)
        var account = findViewById<TextInputEditText>(R.id.profile_account_type)
        var age = findViewById<TextInputEditText>(R.id.profile_age)
        var flag = false
        editFields.setOnClickListener(){
            if(!flag){
                editFields.text = "GUARDAR"
                nombre.isEnabled = true
                number.isEnabled = true
                age.isEnabled = true
                flag = true
                //hacer cosas locas de update

                var docRef = db.collection("users").document("${user?.email}").update(
                    mapOf("name" to nombre.text.toString())
                )

// Update the timestamp field with the value from the server



            }
            else if(flag){
                editFields.text = "edit bish"
                nombre.isEnabled = false
                number.isEnabled = false
                age.isEnabled = false
            }

        }
    }
}