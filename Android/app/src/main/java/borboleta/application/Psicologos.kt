package borboleta.application

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager2.widget.CompositePageTransformer
import androidx.viewpager2.widget.MarginPageTransformer
import androidx.viewpager2.widget.ViewPager2
import com.google.android.material.bottomnavigation.BottomNavigationView
import java.lang.Math.abs

class Psicologos : AppCompatActivity() {
    private lateinit var vpSlider: ViewPager2
    private lateinit var sliderAdapter: SliderAdapter
    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_psicologos)

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
                R.id.message_icon -> {
                    // Respond to navigation item 2 click
                    startActivity(Intent(this, ActiveChats::class.java))
                    true
                }
                else -> false
            }
        }

        initView()
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
        data.add(R.drawable.puser1)
        data.add(R.drawable.puser2)
        data.add(R.drawable.puser4)
        data.add(R.drawable.success)
        return data
    }




}