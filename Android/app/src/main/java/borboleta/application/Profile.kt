package borboleta.application

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import com.bumptech.glide.request.RequestOptions
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.FirebaseStorage

class Profile : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_profile)
        //DATABASE
        var db = Firebase.firestore
        auth = Firebase.auth
        val storage = FirebaseStorage.getInstance()

        //Nav var
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
        var profilePic = findViewById<ImageView>(R.id.profile_picture)
        var editFields = findViewById<Button>(R.id.edit_button_profile)
        var nombre = findViewById<TextInputEditText>(R.id.profile_name)
        var number = findViewById<TextInputEditText>(R.id.profile_number)
        var account = findViewById<TextInputEditText>(R.id.profile_account_type)
        var age = findViewById<TextInputEditText>(R.id.profile_age)

        var botonexit = findViewById<ImageButton>(R.id.logout_button_profile)
        botonexit.setOnClickListener(){
            Firebase.auth.signOut()
            startActivity(Intent(this, Login::class.java))
        }

        val user = auth.currentUser

        storage.reference.child("profilePics/${user?.email}.png").downloadUrl.addOnSuccessListener { url ->
            GlideApp.with(this)
                .load(url.toString())
                .apply(
                    RequestOptions()
                    .circleCrop()
                )
                .into(profilePic)
        }

        //Get info from user
        db.collection("users").document("${user?.email}").get().addOnSuccessListener { doc ->
            //Display data from DB
            var data = doc.get("data") as? Map<String, String>
            nombre.setText(data?.get("name"))
            number.setText(data?.get("phone"))
            account.setText(data?.get("accountType"))
            age.setText(data?.get("birthday"))

            //Edit Save Button function
            var flag = false
            editFields.setOnClickListener(){
                if(!flag){
                    editFields.text = "Guardar"
                    nombre.isEnabled = true
                    number.isEnabled = true
                    age.isEnabled = true
                    flag = true

                }
                else if(flag){
                    editFields.text = "Editar"
                    nombre.isEnabled = false
                    number.isEnabled = false
                    age.isEnabled = false

                    //hacer cosas locas de update
                    db.collection("users").document("${user?.email}").update(mapOf(
                        "data.name" to nombre.text.toString(),
                        "data.phone" to number.text.toString(),
                        "data.birthday" to age.text.toString()
                    ))
                }

            }
        }
    }
}