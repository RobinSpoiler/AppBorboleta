package borboleta.application

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.bottomnavigation.BottomNavigationView

class Home : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_home)

        var navbar = findViewById<BottomNavigationView>(R.id.bottomNavigationView_navbar)
        navbar.menu.findItem(R.id.home_icon).isChecked = true;
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