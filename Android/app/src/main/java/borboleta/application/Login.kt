package borboleta.application

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.WindowManager


@Suppress("DEPRECATION")
class Login : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)

        window.setFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
            WindowManager.LayoutParams.FLAG_FULLSCREEN,
        )
    }

}