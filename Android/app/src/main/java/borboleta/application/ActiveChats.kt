package borboleta.application

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.ktx.Firebase


class ActiveChats : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth

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
                else -> false
            }
        }


        auth = Firebase.auth

        val user = auth.currentUser

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

            }

            /*for(doc in documents){
                val dynamicCardview = CardView(this)
                val dynamicTextview = TextView(this)
                val dynamicImageview = ImageView(this)


                var layout = findViewById<LinearLayout>(R.id.mainlayout)

                dynamicImageview.setImageResource(R.drawable.logomariposa)
                dynamicImageview.layoutParams= LinearLayout.LayoutParams(150, 100)
                dynamicImageview.x = 80F

                var name : String = doc.getField<String>("data.name").toString()
                dynamicTextview.text = name
                dynamicTextview.x = 220F

                dynamicCardview.layoutParams = LinearLayout.LayoutParams(2000, 200)
                dynamicCardview.addView(dynamicImageview)
                dynamicCardview.addView(dynamicTextview)

                layout.addView(dynamicCardview)

            }*/

        }


    }
}


