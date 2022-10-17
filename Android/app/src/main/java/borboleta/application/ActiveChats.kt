package borboleta.application

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.ktx.getField


class ActiveChats : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_active_chats)

        val db = FirebaseFirestore.getInstance()

        val docRef = db.collection("users").document("K53rfbNnTJctTAyhID7D").get().addOnSuccessListener { doc ->
            var message = doc.getField<String>("0.message")
            println(message)
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