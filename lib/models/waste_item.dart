enum BinType {
  recycling,
  compost,
  landfill,
  eWaste,
}

class WasteItem {
  final String name;
  final String imagePath;
  final BinType correctBin;
  final String fact;

  WasteItem({
    required this.name,
    required this.imagePath,
    required this.correctBin,
    required this.fact,
  });
}

class WasteItemsRepository {
  static List<WasteItem> getWasteItems() {
    return [
      WasteItem(
        name: 'Plastic Bottle',
        imagePath: 'assets/images/plastic_bottle.png',
        correctBin: BinType.recycling,
        fact: 'Plastic bottles can take up to 450 years to decompose in landfills.',
      ),
      WasteItem(
        name: 'Banana Peel',
        imagePath: 'assets/images/banana_peel.png',
        correctBin: BinType.compost,
        fact: 'Banana peels can decompose in as little as 2 weeks in a compost bin.',
      ),
      WasteItem(
        name: 'Broken Headphones',
        imagePath: 'assets/images/headphones.png',
        correctBin: BinType.eWaste,
        fact: 'E-waste contains valuable materials that can be recovered and recycled.',
      ),
      WasteItem(
        name: 'Used Tissue',
        imagePath: 'assets/images/tissue.png',
        correctBin: BinType.landfill,
        fact: 'Used tissues are contaminated and cannot be recycled or composted.',
      ),
      WasteItem(
        name: 'Cardboard Box',
        imagePath: 'assets/images/cardboard.png',
        correctBin: BinType.recycling,
        fact: 'Recycling one ton of cardboard saves 17 trees and 7,000 gallons of water.',
      ),
      WasteItem(
        name: 'Apple Core',
        imagePath: 'assets/images/apple_core.png',
        correctBin: BinType.compost,
        fact: 'Apple cores can be composted and turned into nutrient-rich soil.',
      ),
      WasteItem(
        name: 'Old Smartphone',
        imagePath: 'assets/images/smartphone.png',
        correctBin: BinType.eWaste,
        fact: 'Smartphones contain precious metals like gold, silver, and copper that can be recycled.',
      ),
      WasteItem(
        name: 'Styrofoam Cup',
        imagePath: 'assets/images/styrofoam.png',
        correctBin: BinType.landfill,
        fact: 'Styrofoam can take over 500 years to decompose and is rarely accepted for recycling.',
      ),
      WasteItem(
        name: 'Glass Bottle',
        imagePath: 'assets/images/glass_bottle.png',
        correctBin: BinType.recycling,
        fact: 'Glass can be recycled endlessly without loss in quality or purity.',
      ),
      WasteItem(
        name: 'Coffee Grounds',
        imagePath: 'assets/images/coffee_grounds.png',
        correctBin: BinType.compost,
        fact: 'Coffee grounds add nitrogen to compost and can help neutralize odors.',
      ),
      WasteItem(
        name: 'Old Battery',
        imagePath: 'assets/images/battery.png',
        correctBin: BinType.eWaste,
        fact: 'Batteries contain toxic chemicals that can leak into soil and water if not properly disposed.',
      ),
      WasteItem(
        name: 'Plastic Wrap',
        imagePath: 'assets/images/plastic_wrap.png',
        correctBin: BinType.landfill,
        fact: 'Most plastic wrap cannot be recycled due to food contamination and its thin material.',
      ),
    ];
  }
}
