import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/song.dart';

// Define events.
abstract class MusicEvent {
  const MusicEvent();
}

class PlayPauseEvent extends MusicEvent {
  const PlayPauseEvent();
}

class NextSongEvent extends MusicEvent {}

class PreviousSongEvent extends MusicEvent {}

// Define states.
class MusicState {
  final bool isPlaying;
  final int currentSongIndex;
  final List<Song> songs;

  MusicState({
    required this.isPlaying,
    required this.currentSongIndex,
    required this.songs,
  });

  MusicState copyWith({
    bool? isPlaying,
    int? currentSongIndex,
    List<Song>? songs,
  }) {
    return MusicState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentSongIndex: currentSongIndex ?? this.currentSongIndex,
      songs: songs ?? this.songs,
    );
  }
}

const List<Song> songs = [
  Song(
    title: 'Billie Jean',
    artist: 'Michael Jackson',
    duration: '4:54',
    imageUrl: 'https://via.placeholder.com/150/0000FF/808080?text=Billie+Jean',
  ),
  Song(
    title: 'Sweet Child o\' Mine',
    artist: 'Guns N\' Roses',
    duration: '5:56',
    imageUrl:
        'https://via.placeholder.com/150/FF0000/FFFFFF?text=Sweet+Child+o%27+Mine',
  ),
  Song(
    title: 'Like a Prayer',
    artist: 'Madonna',
    duration: '5:41',
    imageUrl:
        'https://via.placeholder.com/150/FFFF00/000000?text=Like+a+Prayer',
  ),
  Song(
    title: 'Smells Like Teen Spirit',
    artist: 'Nirvana',
    duration: '5:01',
    imageUrl:
        'https://via.placeholder.com/150/00FF00/000000?text=Smells+Like+Teen+Spirit',
  ),
  Song(
    title: 'Wonderwall',
    artist: 'Oasis',
    duration: '4:18',
    imageUrl: 'https://via.placeholder.com/150/FFA500/FFFFFF?text=Wonderwall',
  ),
];

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc()
      : super(MusicState(
          isPlaying: false,
          currentSongIndex: 0,
          songs: songs,
        )) {
    on<PlayPauseEvent>(_onPlayPause);
    on<NextSongEvent>(_onNextSong);
    on<PreviousSongEvent>(_onPreviousSong);
  }

  // Event handler for play/pause.
  void _onPlayPause(PlayPauseEvent event, Emitter<MusicState> emit) {
    final next = state.copyWith(isPlaying: !state.isPlaying);
    emit(next);
  }

  // Event handler for next song.
  void _onNextSong(NextSongEvent event, Emitter<MusicState> emit) {
    final int nextIndex;
    if (state.currentSongIndex == state.songs.length - 1) {
      nextIndex = 0;
    } else {
      nextIndex = state.currentSongIndex + 1;
    }

    final next = state.copyWith(currentSongIndex: nextIndex);
    emit(next);
  }

  // Event handler for previous song.
  void _onPreviousSong(PreviousSongEvent event, Emitter<MusicState> emit) {
    final int nextIndex;
    if (state.currentSongIndex == 0) {
      nextIndex = state.songs.length - 1;
    } else {
      nextIndex = state.currentSongIndex - 1;
    }

    final next = state.copyWith(currentSongIndex: nextIndex);
    emit(next);
  }
}
