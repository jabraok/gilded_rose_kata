class BackstageUpdater
  def self.update(item)
    if item.quality < 50
      item.quality += 1
      if item.sell_in < 11
        if item.quality < 50
          item.quality += 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality += 1
        end
      end
    end

    item.sell_in -= 1

    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end
end

class AgedBrieUpdater
  def self.update(item)
    if item.quality < 50
      item.quality += 1
    end

    item.sell_in -= 1

    if item.sell_in < 0
      if item.quality < 50
        item.quality += 1
      end
    end
  end
end

class NormalUpdater
  def self.update(item)
    if item.quality > 0
      item.quality -= 1
    end

    item.sell_in -= 1

    if item.sell_in < 0
      if item.quality > 0
        item.quality -= 1
      end
    end
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
