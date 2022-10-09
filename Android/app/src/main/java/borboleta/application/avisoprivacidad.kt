package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton

class avisoprivacidad : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_avisoprivacidad)
       val btnRetro = findViewById<Button>(R.id.aceptar)
        //IR A RETRO
        btnRetro.setOnClickListener(){
            startActivity(Intent(this, Retro::class.java))
        }
        //GO BACK TO PREFERENCES
        val backAviso = findViewById<ImageButton>(R.id.backbutton3)
        backAviso.setOnClickListener(){
            startActivity(Intent(this, Preferencias::class.java))
        }

        //Reject terms and conditions
        val btnReject = findViewById<Button>(R.id.rechazar)
        btnReject.setOnClickListener(){
            startActivity(Intent(this, Login::class.java))
        }

    }
}