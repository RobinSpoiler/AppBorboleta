package borboleta.application

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton

class Home : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)

        val btnLogoSpotify = findViewById<ImageButton>(R.id.logo_spotify_borboleta_home)
        // set on-click listener
        btnLogoSpotify.setOnClickListener {
            val i = Intent(Intent.ACTION_VIEW, Uri.parse("https://open.spotify.com/show/0MAY6vcrhDT46Czrs3ZLus?si=PdGqS8h_TYOASZcyEE65kA&nd=1"))
            startActivity(i)
        }

        val btnConocerMas = findViewById<Button>(R.id.btn_conocermas_home)
        // set on-click listener
        btnConocerMas.setOnClickListener {
            val i = Intent(Intent.ACTION_VIEW, Uri.parse("https://www.borboleta.live/"))
            startActivity(i)
        }

    }
}