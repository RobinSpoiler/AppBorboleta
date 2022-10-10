package borboleta.application

import android.content.Intent
import android.content.res.Resources
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.recyclerview.widget.RecyclerView
import androidx.viewpager2.widget.CompositePageTransformer
import androidx.viewpager2.widget.MarginPageTransformer
import androidx.viewpager2.widget.ViewPager2
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.StorageReference
import com.google.firebase.storage.ktx.storage

class Psicologos : AppCompatActivity() {
    private lateinit var auth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_psicologos)
        // Access a Cloud Firestore instance from your Activity
        val db = Firebase.firestore
        val users = db.collection("users")
        auth = Firebase.auth


        var navbar = findViewById<BottomNavigationView>(R.id.bottomNavigationView_navbar)
        navbar.menu.findItem(R.id.heart_icon).isChecked = true;
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
                else -> false
            }
        }



        //Create storage reference
        var storage = Firebase.storage
        var storageRef = storage.reference
        var imagesRef: StorageReference? = storageRef.child("images")
///

        val viewPager = findViewById<ViewPager2>(R.id.view_pager)

        viewPager.apply {
            clipChildren = false  // No clipping the left and right items
            clipToPadding = false  // Show the viewpager in full width without clipping the padding
            offscreenPageLimit = 3  // Render the left and right items
            (getChildAt(0) as RecyclerView).overScrollMode =
                RecyclerView.OVER_SCROLL_NEVER // Remove the scroll effect
        }
        val query = users.whereEqualTo("docData.preferences.p1", "2")

        print(query.toString())
        println("AQUI EMPIEZASDFSDF")
        users
            .whereEqualTo("docData.preferences.p1", "2")
            .get()
            .addOnSuccessListener { documents ->
                for (document in documents) {
                    Log.d("retreived info", "${document.id} => ${document.data}")
                    println("AAAAAAAAAAAAAA RETREIVED")
                }
            }
            .addOnFailureListener { exception ->
                Log.w("AAAAAAAAAAAAAA NOT RETREIVED", "Error getting documents: ", exception)

                println("AAAAAAAAAAAAAA NOOOOOO RETREIVED")
            }
        println("AQUI TERMINAAAA")
        //ESTE ES EL ARRAY CON LA INFORMACION
        val demoData = arrayListOf(
            "Esta sería la ñam",
            "Esta la segunda",
            "Praesent TERCERA nibh.",
            "Aliquam sodales imperdiet augue at consectetur. Suspendisse dui mauris, tincidunt non auctor quis, facilisis et tellus.",
            "Ut non tincidunt neque, et sodales ligula. Quisque interdum in dui sit amet sagittis. Curabitur erat magna, maximus quis libero quis, dapibus eleifend orci."
        )

        viewPager.adapter = CarouselRVAdapter(demoData)

        val compositePageTransformer = CompositePageTransformer()
        compositePageTransformer.addTransformer(MarginPageTransformer((40 * Resources.getSystem().displayMetrics.density).toInt()))
        viewPager.setPageTransformer(compositePageTransformer)
    }
}