package borboleta.application

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Typeface
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.cardview.widget.CardView
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.FirebaseStorage


class ActiveChats : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth

    @SuppressLint("SetTextI18n")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_active_chats)

        var navbar = findViewById<BottomNavigationView>(R.id.bottomNavigationView_navbar)
        navbar.menu.findItem(R.id.message_icon).isChecked = true;
        navbar.setOnItemSelectedListener{ item ->
            when(item.itemId) {
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


        auth = Firebase.auth

        val user = auth.currentUser

        val storage = FirebaseStorage.getInstance()


        val db = FirebaseFirestore.getInstance()
        println(user?.email)

        val docRef = db.collection("users").document("${user?.email}").get().addOnSuccessListener { doc ->
            var array = doc.get("activeChats") as? ArrayList<Map<String, Any>>

            for(i in array!!){
                var with = i.get("with") as String
                var chatID = i.get("chatID") as String
                var chatName = i.get("chatName") as String
                var lastMessage = i.get("lastMessage") as Map<String, String>
                var sender = lastMessage.get("sender")
                var time = lastMessage.get("time")
                var message = lastMessage.get("message")

                val dynamicCardview = CardView(this)
                val dynamicName = TextView(this)
                val dynamicMessage = TextView(this)
                val dynamicTime = TextView(this)
                val dynamicPhoto = ImageView(this)


                var layout = findViewById<LinearLayout>(R.id.mainlayout)

                val ref = storage.reference.child("profilePics/$with.png").downloadUrl.addOnSuccessListener { url ->
                    GlideApp.with(this)
                        .load(url.toString())
                        .circleCrop()
                        .override(100,100)
                        .into(dynamicPhoto)
                }

                var margin : Int = layout.width / 2
                dynamicPhoto.x = -margin.toFloat() + 140



                dynamicName.text = chatName
                dynamicName.x = 260F
                dynamicName.setTypeface(null, Typeface.BOLD)

                if(sender == user?.email.toString()){
                    dynamicMessage.text = "Tú: $message"
                    dynamicMessage.x = 260F
                    dynamicMessage.y = 70F
                }else{
                    dynamicMessage.text = message
                    dynamicMessage.x = 260F
                    dynamicMessage.y = 70F
                }

                dynamicTime.text = time
                dynamicTime.textAlignment = View.TEXT_ALIGNMENT_VIEW_END
                dynamicTime.x = -30F

                dynamicCardview.layoutParams = LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 200)
                dynamicCardview.addView(dynamicPhoto)
                dynamicCardview.addView(dynamicName)
                dynamicCardview.addView(dynamicMessage)
                dynamicCardview.addView(dynamicTime)

                layout.addView(dynamicCardview)

            }



        }


    }
}


