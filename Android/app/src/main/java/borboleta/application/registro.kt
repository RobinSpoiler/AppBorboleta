package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton

class registro : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro)


        val btnRegisterSecond = findViewById<ImageButton>(R.id.nextbutton)
        btnRegisterSecond.setOnClickListener(){
            startActivity(Intent(this, registro2::class.java))
        }

        val btnRegisterBack = findViewById<ImageButton>(R.id.backbutton)
        btnRegisterBack.setOnClickListener(){
            startActivity(Intent(this, Login::class.java))
        }
    }


}