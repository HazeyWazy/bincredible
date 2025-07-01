class LeaderboardEntry {
  final String playerInitials;
  final int score;
  final DateTime date;

  LeaderboardEntry({
    required this.playerInitials,
    required this.score,
    required this.date,
  });
}

class LeaderboardRepository {
  static List<LeaderboardEntry> getDummyEntries() {
    return [
      LeaderboardEntry(
        playerInitials: 'ABC',
        score: 950,
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      LeaderboardEntry(
        playerInitials: 'XYZ',
        score: 920,
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      LeaderboardEntry(
        playerInitials: 'JKL',
        score: 880,
        date: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      LeaderboardEntry(
        playerInitials: 'MNO',
        score: 850,
        date: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      LeaderboardEntry(
        playerInitials: 'PQR',
        score: 820,
        date: DateTime.now().subtract(const Duration(hours: 12)),
      ),
    ];
  }
}
