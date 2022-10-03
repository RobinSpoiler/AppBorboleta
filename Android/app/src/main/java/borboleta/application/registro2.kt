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



        val btnRegister2Second = findViewById<ImageButton>(R.id.nextbutton2)
        btnRegister2Second.setOnClickListener(){
            /*Completar registro en la BD*/
            val docData = hashMapOf(
                "birthday" to "12-09-2002",
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