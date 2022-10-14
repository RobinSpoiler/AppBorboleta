package borboleta.application


import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.ListAdapter
import com.bumptech.glide.Glide
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase
import com.google.firebase.storage.FirebaseStorage

class SliderAdapter : ListAdapter<Int,RecyclerView.ViewHolder>(DiffCallback()) {

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        /*val ivWallpaper: ImageView = itemView.findViewById(R.id.ivWallpaper)
        fun onBind(wallpaper: Int){ //iterador
            GlideApp.with(ivWallpaper) //visible
                .load("com.google.android.gms.tasks.zzw@ccdf6ae") //que
                .into(ivWallpaper) // en donde
        }*/
        val db = Firebase.firestore
        var storage = FirebaseStorage.getInstance()
        var query = db.collection("users").whereEqualTo("data.accountType", "psychologist")
            .get()
            .addOnSuccessListener { documents ->
                for (document in documents) {

                    Log.d("yai", "${document.id} => ${document.data}")
                    val ref = storage.reference.child("profilePics/${document.id}.png").downloadUrl.addOnSuccessListener { Url ->
                        val ivWallpaper: ImageView = itemView.findViewById(R.id.ivWallpaper)
                        GlideApp.with(ivWallpaper)
                            .load(Url.toString())
                            .into(ivWallpaper)
                    }
                }
            }

            .addOnFailureListener { exception ->
                Log.w("fail", "Error getting documents: ", exception)
            }

    }
    private class DiffCallback : DiffUtil.ItemCallback<Int>() {
        override fun areItemsTheSame(oldItem: Int, newItem: Int) = oldItem == newItem

        override fun areContentsTheSame(oldItem: Int, newItem: Int) = oldItem == newItem
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return ViewHolder(LayoutInflater.from(parent.context).inflate(R.layout.items_carousel, parent, false))
    }

    override fun onBindViewHolder(holder: RecyclerView.ViewHolder, position: Int) {
        val item =getItem(position)
        val hold = holder as ViewHolder
        hold.query
    }


}