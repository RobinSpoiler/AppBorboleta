package borboleta.application

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class navbar : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_navbar)
    }
}