package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton

class avisoprivacidad : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_avisoprivacidad)
       /* val btnRegisterSecond = findViewById<ImageButton>(R.id.nextbutton)
        btnRegisterSecond.setOnClickListener(){
            startActivity(Intent(this, registro2::class.java))
        }*/

        val btnAviso = findViewById<ImageButton>(R.id.backbutton3)
        btnAviso.setOnClickListener(){
            startActivity(Intent(this, registro2::class.java))
    }

    }
}