package borboleta.application

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.widget.*
import com.google.android.material.textfield.TextInputEditText
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import java.time.format.DateTimeFormatter
import java.util.*



@Suppress("NAME_SHADOWING")
class registro2 : AppCompatActivity() {

    @SuppressLint("MissingInflatedId")

    override fun onCreate(savedInstanceState: Bundle?) {
        // Access a Cloud Firestore instance from your Activity
        val db = Firebase.firestore

        supportActionBar?.hide()
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_registro2)

        val datePicker = findViewById<DatePicker>(R.id.fecha)
        val telefono = findViewById<TextInputEditText>(R.id.inputtelefono)
        val pronombre = findViewById<TextView>(R.id.selector)
        val nombre = findViewById<TextInputEditText>(R.id.inputnombre)
        val today = Calendar.getInstance()
        datePicker.init(
            today.get(Calendar.YEAR), today.get(Calendar.MONTH),
            today.get(Calendar.DAY_OF_MONTH)
        )
        { view, year, month, day ->
            val month = month + 1
            val msg = "$day/$month/$year"
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



        val btnRegister2Second = findViewById<ImageButton>(R.id.nextbutton2)
        btnRegister2Second.setOnClickListener(){
            var month = datePicker.month + 1
            var monthstr = month.toString()
            if(month < 10){
                monthstr = "0" + month
            }

            var day = datePicker.dayOfMonth
            var daystr = datePicker.dayOfMonth.toString()
            if(day < 10){
                daystr = "0" + day
            }

            var year = datePicker.year.toString()
            var date = year + "-" + monthstr + "-" + daystr

            /*Completar registro en la BD*/
            var docData = hashMapOf(
                /*"name" to nombre.text.toString(),*/
                "birthday" to date,
                "phone" to telefono.text.toString(),
                "pronouns" to pronombre.text.toString(),
            )

            db.collection("users").document("israez@tec.mx")
                .set(docData)
                .addOnSuccessListener { Log.d("Success", "DocumentSnapshot successfully written!") }
                .addOnFailureListener { e -> Log.w("Fail", "Error writing document", e) }


            startActivity(Intent(this, avisoprivacidad::class.java))
        }

        val btnRegister2Back = findViewById<ImageButton>(R.id.backbutton2)
        btnRegister2Back.setOnClickListener(){
            startActivity(Intent(this, registro::class.java))
        }
    }
}