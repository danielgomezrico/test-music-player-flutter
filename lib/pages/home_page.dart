import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/model_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the MusicBloc.
    final musicBloc = context.watch<MusicBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: musicBloc.state.songs.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final song = songs[index];
              final isSelected = musicBloc.state.currentSongIndex == index;

              return ListTile(
                selected: isSelected,
                title: Text(song.title),
                subtitle: Text(song.artist),
              );
            },
          ),
          const Spacer(),
          // Control bar with Play, Previous, and Next buttons.
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous button.
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  onPressed: () {
                    musicBloc.add(PreviousSongEvent());
                  },
                ),
                // Play/Pause button.
                IconButton(
                  icon: musicBloc.state.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  onPressed: () {
                    musicBloc.add(const PlayPauseEvent());
                  },
                ),
                // Next button.
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    musicBloc.add(NextSongEvent());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
