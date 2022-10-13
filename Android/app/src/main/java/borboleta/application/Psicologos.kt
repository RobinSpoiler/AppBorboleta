package borboleta.application

import android.content.Intent
import android.content.res.Resources
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.RecyclerView
import androidx.viewpager2.widget.CompositePageTransformer
import androidx.viewpager2.widget.MarginPageTransformer
import androidx.viewpager2.widget.ViewPager2
import com.google.android.material.bottomnavigation.BottomNavigationView
import java.lang.Math.abs
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.FirebaseStorage

class Psicologos : AppCompatActivity() {
    private lateinit var vpSlider: ViewPager2
    private lateinit var sliderAdapter: SliderAdapter
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_psicologos)
        initView()
        getProfileImg()
    }

    private fun getProfileImg() : String{
        val storage = FirebaseStorage.getInstance()

        val url = storage.reference.child("profilePics/puser1@gmail.com.png").downloadUrl.addOnSuccessListener { Url ->
            val img = findViewById<ImageView>(R.id.ivWallpaper)
            GlideApp.with(this)
                .load(Url.toString())
                .into(img)
        }
        println(url.toString())
        return url.toString()
    }



    private fun initView(){
        vpSlider = findViewById(R.id.vpSlider)
        //num de photos que se "ven" en pantalla
        vpSlider.offscreenPageLimit = 3
        vpSlider.setPageTransformer(getTransformation())
        sliderAdapter = SliderAdapter()
        vpSlider.adapter = sliderAdapter
        sliderAdapter.submitList(getWallpapers())
    }
    //esta es como la animación de los psicólogos para que las cards se hagan pequeñas si estan al lado
    private fun getTransformation():CompositePageTransformer{
        val transform = CompositePageTransformer()
        transform.addTransformer(MarginPageTransformer(30))
        transform.addTransformer{page, position ->
            page.scaleY = 0.85f + (1 - abs(position)) * 0.15f
        }
        return transform
    }

    //Este es el arreglo donde van las imágenes
    private fun getWallpapers(): List<Int>{
        val data = arrayListOf<Int>()
        data.add(R.drawable.spotify)
        data.add(R.drawable.success)
        return data
    }




}