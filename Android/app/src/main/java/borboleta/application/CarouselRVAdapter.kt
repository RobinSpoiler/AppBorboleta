package borboleta.application


import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.ListAdapter
import com.google.firebase.storage.FirebaseStorage

class SliderAdapter : ListAdapter<Int,RecyclerView.ViewHolder>(DiffCallback()) {

    inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView){
        /*val ivWallpaper: ImageView = itemView.findViewById(R.id.ivWallpaper)
        fun onBind(wallpaper: Int){ //iterador
            GlideApp.with(ivWallpaper) //visible
                .load("com.google.android.gms.tasks.zzw@ccdf6ae") //que
                .into(ivWallpaper) // en donde
        }*/
        var storage = FirebaseStorage.getInstance()

        val ref = storage.reference.child("profilePics/puser1@gmail.com.png").downloadUrl.addOnSuccessListener { Url ->
            val ivWallpaper: ImageView = itemView.findViewById(R.id.ivWallpaper)
            GlideApp.with(ivWallpaper)
                .load(Url.toString())
                .into(ivWallpaper)
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
        hold.ref
    }


}