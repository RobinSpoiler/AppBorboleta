package borboleta.application

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class registro : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro)
    }
}