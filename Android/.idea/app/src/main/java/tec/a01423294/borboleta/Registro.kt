package tec.a01423294.borboleta

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class Registro : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {

        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro)
    }
}