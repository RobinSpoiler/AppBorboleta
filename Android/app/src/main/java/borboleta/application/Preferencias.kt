package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageButton

class Preferencias : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_preferencias)
        supportActionBar?.hide()

        //Go to Aviso de priv
        val nextPreferencias = findViewById<ImageButton>(R.id.nextbutton5)
        nextPreferencias.setOnClickListener(){
            startActivity(Intent(this, avisoprivacidad::class.java))
        }
        //Go to Aviso de priv
        val backPreferencias = findViewById<ImageButton>(R.id.backbutton5)
        backPreferencias.setOnClickListener(){
            startActivity(Intent(this, registro2::class.java))
        }
    }


}