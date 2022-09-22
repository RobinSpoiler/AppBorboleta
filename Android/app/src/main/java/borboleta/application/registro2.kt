package borboleta.application

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.*
import java.util.*


@Suppress("NAME_SHADOWING")
class registro2 : AppCompatActivity() {

    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro2)

        val datePicker = findViewById<DatePicker>(R.id.fecha)
        val today = Calendar.getInstance()
        datePicker.init(
            today.get(Calendar.YEAR), today.get(Calendar.MONTH),
            today.get(Calendar.DAY_OF_MONTH)
        )
        { view, year, month, day ->
            val month = month + 1
            val msg = "You Selected: $day/$month/$year"
        }

/*
        Toast.makeText(this@registro2, msg, Toast.LENGTH_SHORT).show()
*/


        // access the items of the list
        val value = resources.getStringArray(R.array.arraypronombres)

        // access the spinner
        val spinner = findViewById<Spinner>(R.id.list)
        if (spinner != null) {
            val adapter = ArrayAdapter(
                this,
                android.R.layout.simple_spinner_item, value
            )
            spinner.adapter = adapter
        }
    }



}