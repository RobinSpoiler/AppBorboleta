package borboleta.application

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.CheckBox
import android.widget.ImageButton

class Preferencias : AppCompatActivity() {
    fun check(array : Array<CheckBox>, button : CheckBox, result : IntArray, question : Int, option : Int) {
        for (element in array) {
            if(element != button)
                element.isChecked = false
        }
        result[question] = option
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_preferencias)
        supportActionBar?.hide()


        val uno_a = (findViewById<CheckBox>(R.id.unoa))
        val uno_b = findViewById<CheckBox>(R.id.unob)
        val uno_c = findViewById<CheckBox>(R.id.unoc)
        val uno_d = findViewById<CheckBox>(R.id.unod)

        val dos_a = findViewById<CheckBox>(R.id.dosa)
        val dos_b = findViewById<CheckBox>(R.id.dosb)

        val tres_a = findViewById<CheckBox>(R.id.tresa)
        val tres_b = findViewById<CheckBox>(R.id.tresb)
        val tres_c = findViewById<CheckBox>(R.id.tresc)
        val tres_d = findViewById<CheckBox>(R.id.tresd)
        val tres_e = findViewById<CheckBox>(R.id.trese)

        val cuatro_a = findViewById<CheckBox>(R.id.cuatroa)
        val cuatro_b = findViewById<CheckBox>(R.id.cuatrob)
        val cuatro_c = findViewById<CheckBox>(R.id.cuatroc)
        val cuatro_d = findViewById<CheckBox>(R.id.cuatrod)
        val cuatro_e = findViewById<CheckBox>(R.id.cuatroe)
        val cuatro_f = findViewById<CheckBox>(R.id.cuatrof)

        val seis_a = findViewById<CheckBox>(R.id.seisa)
        val seis_b = findViewById<CheckBox>(R.id.seisb)
        val seis_c = findViewById<CheckBox>(R.id.seisc)
        val seis_d = findViewById<CheckBox>(R.id.seisd)
        val seis_e = findViewById<CheckBox>(R.id.seise)


        var firstQuestion : Array<CheckBox> = arrayOf<CheckBox>(uno_a, uno_b,uno_c, uno_d)
        var secondQuestion : Array<CheckBox> = arrayOf<CheckBox>(dos_a, dos_b)
        var thirdQuestion : Array<CheckBox> = arrayOf<CheckBox>(tres_a, tres_b,tres_c, tres_d, tres_e)
        var fourthQuestion : Array<CheckBox> = arrayOf<CheckBox>(cuatro_a, cuatro_b,cuatro_c, cuatro_d, cuatro_e, cuatro_f)
        var sixthQuestion : Array<CheckBox> = arrayOf<CheckBox>(seis_a, seis_b,seis_c, seis_d, seis_e)
        var results = IntArray(6)

        uno_a.setOnClickListener{check(firstQuestion, uno_a, results, 0, 0) }
        uno_b.setOnClickListener{check(firstQuestion, uno_b, results, 0, 1) }
        uno_c.setOnClickListener{check(firstQuestion, uno_c, results, 0 ,2) }
        uno_d.setOnClickListener{check(firstQuestion, uno_d, results,0 , 3) }

        dos_a.setOnClickListener{check(secondQuestion, dos_a,results, 1, 0) }
        dos_b.setOnClickListener{check(secondQuestion, dos_b, results, 1, 1) }

        tres_a.setOnClickListener{check(thirdQuestion, tres_a, results, 2, 0) }
        tres_b.setOnClickListener{check(thirdQuestion, tres_b, results, 2, 1) }
        tres_c.setOnClickListener{check(thirdQuestion, tres_c, results, 2, 2) }
        tres_d.setOnClickListener{check(thirdQuestion, tres_d, results, 2, 3)}

        cuatro_a.setOnClickListener{check(fourthQuestion, cuatro_a, results, 3, 0) }
        cuatro_b.setOnClickListener{check(fourthQuestion, cuatro_b, results, 3, 1) }
        cuatro_c.setOnClickListener{check(fourthQuestion, cuatro_c, results, 3, 2) }
        cuatro_d.setOnClickListener{check(fourthQuestion, cuatro_d, results, 3, 3) }
        cuatro_e.setOnClickListener{check(fourthQuestion, cuatro_e, results, 3, 4) }
        cuatro_f.setOnClickListener{check(fourthQuestion, cuatro_f, results, 3, 5) }

        seis_a.setOnClickListener(){check(sixthQuestion, seis_a, results, 5, 0) }
        seis_b.setOnClickListener(){check(sixthQuestion, seis_b, results, 5, 1) }
        seis_c.setOnClickListener(){check(sixthQuestion, seis_c, results, 5, 2) }
        seis_d.setOnClickListener(){check(sixthQuestion, seis_d, results, 5,3) }
        seis_e.setOnClickListener(){check(sixthQuestion, seis_e, results, 5, 4) }


        //Go to Aviso de priv
        var nextPreferencias = findViewById<ImageButton>(R.id.nextbutton5)
        nextPreferencias.setOnClickListener(){
            startActivity(Intent(this, avisoprivacidad::class.java))
        }
        //Go to Aviso de priv
        var backPreferencias = findViewById<ImageButton>(R.id.backbutton5)
        backPreferencias.setOnClickListener(){
            startActivity(Intent(this, registro2::class.java))
        }
    }


}