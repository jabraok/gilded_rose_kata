class BackstageUpdater
  def self.update(item)
    item.sell_in -= 1
    return item.quality = 0 if item.sell_in < 0
    return if item.quality >= 50
    return item.quality += 3 if item.sell_in < 5
    return item.quality += 2 if item.sell_in < 10
    item.quality += 1
  end
end

class AgedBrieUpdater
  def self.update(item)
    item.sell_in -= 1
    return if item.quality >= 50
    return item.quality += 2 if item.sell_in <= 0
    item.quality += 1
  end
end

class NormalUpdater
  def self.update(item)
    item.sell_in -= 1
    return if item.quality <= 0
    return item.quality -= 2 if item.sell_in <= 0
    item.quality -= 1
  end
end

class SulfurasUpdater
  def self.update(item)
    # Do nothing
  end
end

ITEM_UPDATERS = {
  'Sulfuras, Hand of Ragnaros': SulfurasUpdater,
  'Backstage passes to a TAFKAL80ETC concert': BackstageUpdater,
  'Aged Brie': AgedBrieUpdater
}.freeze

def update_quality(items)
  items.each do |item|
    (ITEM_UPDATERS[item.name.to_sym] || NormalUpdater).update(item)
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
