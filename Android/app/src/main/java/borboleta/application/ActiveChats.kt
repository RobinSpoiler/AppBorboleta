package borboleta.application

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.cardview.widget.CardView

class ActiveChats : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_active_chats)

        val dynamicCardview = CardView(this)
        val dynamicTextview = TextView(this)
        val dynamicImageview = ImageView(this)


        var layout = findViewById<LinearLayout>(R.id.mainlayout)
// add TextView to LinearLayout
        layout.addView(dynamicCardview)
        layout.addView(dynamicImageview)
        layout.addView(dynamicTextview)

        dynamicCardview.
        dynamicImageview.setImageResource(R.drawable.logomariposa)
        dynamicImageview.layoutParams= LinearLayout.LayoutParams(100, 100)


        dynamicTextview.text = "Dynamically added text"
    }
}