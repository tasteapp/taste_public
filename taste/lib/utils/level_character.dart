class LevelCharacter {
  const LevelCharacter(this.name, this.asset);
  final String name;
  final String asset;
}

const _characters = [
  LevelCharacter("Elvis Parsley", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Post Baloney", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Mike Trout", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Elvis Parsley", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Post Baloney", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Mike Trout", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Elvis Parsley", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Post Baloney", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Mike Trout", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Elvis Parsley", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Post Baloney", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Mike Trout", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Elvis Parsley", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Post Baloney", "assets/characters/elvis_parsley.png"),
  LevelCharacter("Mike Trout", "assets/characters/elvis_parsley.png"),
];
LevelCharacter characterForLevel(int level) =>
    _characters[(level - 1) % _characters.length];
