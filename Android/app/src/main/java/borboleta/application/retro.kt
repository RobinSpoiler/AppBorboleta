package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class Retro : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_retro)

        //IR A HOME O A PSICOLOGOS?
        var btnHome = findViewById<Button>(R.id.btn_backmenu_retro)
        btnHome.setOnClickListener(){
            startActivity(Intent(this, Home::class.java))
        }
    }
}